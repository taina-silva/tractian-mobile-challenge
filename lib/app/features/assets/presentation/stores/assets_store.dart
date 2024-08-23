import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/repositories/companies_repository.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/states/assets_states.dart';

part 'assets_store.g.dart';

class AssetsStore = AssetsStoreBase with _$AssetsStore;

abstract class AssetsStoreBase with Store {
  final ICompaniesRepository _repository;
  List<ReactionDisposer> reactions = [];

  AssetsStoreBase(this._repository) {
    reactions = [
      reaction((_) => _getCompanyAssetsState, (GetCompanyAssetsState state) async {
        if (state is GetCompanyAssetsSuccessState) await _buildOriginalAssetsTree();
      }),
      reaction((_) => _textFilter, (String? text) async => await _applyFilters()),
      reaction((_) => _sensorTypeFilter, (SensorType? sensorType) async => await _applyFilters()),
    ];
  }

  @readonly
  GetCompanyAssetsState _getCompanyAssetsState = GetCompanyAssetsInitialState();

  @readonly
  BuildTreeState _buildTreeState = BuildTreeInitialState();

  @readonly
  SensorType? _sensorTypeFilter;

  @readonly
  String? _textFilter;

  @action
  void setSensorTypeFilter(SensorType? sensorType) {
    _sensorTypeFilter = (sensorType == _sensorTypeFilter) ? null : sensorType;
  }

  @action
  void setTextFilter(String? text) {
    _textFilter = (text == null || text.isEmpty) ? null : text;
  }

  Future<void> _applyFilters() async {
    await _buildOriginalAssetsTree();

    final hasTextFilter = _textFilter != null && _textFilter!.isNotEmpty;
    final hasSensorTypeFilter = _sensorTypeFilter != null;
    if (hasTextFilter || hasSensorTypeFilter) await _buildAssetsTreeWithFilter();
  }

  @action
  Future<void> getCompanyAssets(String companyId) async {
    _getCompanyAssetsState = GetCompanyAssetsLoadingState();

    final results = await Future.wait([
      _repository.getCompanyLocations(companyId),
      _repository.getCompanyAssets(companyId),
    ]);

    List<CompanyLocationModel> locations = [];
    List<CompanyAssetModel> assets = [];

    results[0].fold(
      (l) => _getCompanyAssetsState = GetCompanyAssetsErrorState(l.message),
      (r) => locations = r as List<CompanyLocationModel>,
    );

    results[1].fold(
      (l) => _getCompanyAssetsState = GetCompanyAssetsErrorState(l.message),
      (r) => assets = r as List<CompanyAssetModel>,
    );

    if (_getCompanyAssetsState is! GetCompanyAssetsErrorState) {
      _getCompanyAssetsState = GetCompanyAssetsSuccessState(locations, assets);
    }
  }

  @action
  Future<void> _buildOriginalAssetsTree() async {
    List<CompanyLocationModel> locations =
        List.from((_getCompanyAssetsState as GetCompanyAssetsSuccessState).locations);
    List<CompanyAssetModel> assets =
        (_getCompanyAssetsState as GetCompanyAssetsSuccessState).assets;
    Map<String, TreeItem> treeMap = {};
    List<TreeItem> treeRootItems = [];

    _buildTreeState = BuildTreeLoadingState();

    for (var location in locations) {
      final treeItem = TreeItem(
        id: location.id,
        name: location.name,
        type: TreeItemType.location,
      );
      treeMap[location.id] = treeItem;
      if (location.parentId == null) treeRootItems.add(treeItem);
    }

    for (var location in locations) {
      if (location.parentId != null) {
        final treeItem = treeMap[location.id];
        final parent = treeMap[location.parentId];
        if (parent != null) {
          treeItem!.parentId = parent.id;
          parent.children = List.from(parent.children)..add(treeItem);
        }
      }
    }

    for (var asset in assets) {
      final treeItem = TreeItem(
        id: asset.id,
        name: asset.name,
        type: asset.sensorType != null ? TreeItemType.component : TreeItemType.asset,
        sensorType: asset.sensorType == 'energy'
            ? SensorType.energy
            : asset.sensorType == 'vibration'
                ? SensorType.vibration
                : null,
      );
      treeMap[asset.id] = treeItem;
      if (asset.locationId == null && asset.parentId == null) {
        treeRootItems.add(treeItem);
      }
    }

    for (var asset in assets) {
      final treeItem = treeMap[asset.id];
      final parent = asset.locationId != null
          ? treeMap[asset.locationId]
          : asset.parentId != null
              ? treeMap[asset.parentId]
              : null;
      if (parent != null) {
        treeItem!.parentId = parent.id;
        parent.children = List.from(parent.children)..add(treeItem);
      }
    }

    _buildTreeState = BuildTreeSuccessState(treeMap, treeRootItems);
  }

  @action
  Future<void> _buildAssetsTreeWithFilter() async {
    Map<String, TreeItem> treeMap = (_buildTreeState as BuildTreeSuccessState).treeMap;
    _buildTreeState = BuildTreeLoadingState();

    List<TreeItem> filteredItems = [];
    List<TreeItem> filteredItemsParents = [];

    bool hasTextFilter = _textFilter?.isNotEmpty ?? false;
    bool hasSensorTypeFilter = _sensorTypeFilter != null;

    for (var item in treeMap.values) {
      bool matchesTextFilter =
          hasTextFilter && item.name.toLowerCase().contains(_textFilter!.toLowerCase());
      bool matchesSensorTypeFilter = hasSensorTypeFilter && item.sensorType == _sensorTypeFilter;

      if (matchesTextFilter || matchesSensorTypeFilter) {
        filteredItems.add(item);
        TreeItem? parent = treeMap[item.parentId];
        if (parent != null) filteredItemsParents.add(parent);
      }
    }

    List<TreeItem> treeRootItems =
        _buildTreeRootItems(filteredItems, filteredItemsParents, treeMap);

    if (hasSensorTypeFilter && hasTextFilter) {
      treeRootItems = _filterRootItemsByDescendantName(treeRootItems, _textFilter!);
    }

    _buildTreeState = BuildTreeSuccessState(treeMap, treeRootItems);
  }

  List<TreeItem> _filterRootItemsByDescendantName(List<TreeItem> rootItems, String targetText) {
    List<TreeItem> finalRootItems = [];

    for (var rootItem in rootItems) {
      if (_hasDescendantWithName(rootItem, targetText)) {
        finalRootItems.add(rootItem);
      }
    }

    return finalRootItems;
  }

  bool _hasDescendantWithName(TreeItem item, String targetText) {
    if (item.name.toLowerCase().contains(targetText.toLowerCase())) return true;

    for (var child in item.children) {
      if (_hasDescendantWithName(child, targetText)) return true;
    }

    return false;
  }

  TreeItem _getRootItem(TreeItem currentItem, List<TreeItem> filteredItems,
      List<TreeItem> filteredItemsParents, Map<String, TreeItem> treeMap) {
    TreeItem? parent = treeMap[currentItem.parentId];
    if (parent == null) return currentItem;

    parent.children = parent.children.where((child) {
      return filteredItems.any((i) => i.id == child.id) ||
          filteredItemsParents.any((i) => i.id == child.id);
    }).toList();

    filteredItemsParents.add(parent);

    return _getRootItem(parent, filteredItems, filteredItemsParents, treeMap);
  }

  List<TreeItem> _buildTreeRootItems(
    List<TreeItem> filteredItems,
    List<TreeItem> filteredItemsParents,
    Map<String, TreeItem> treeMap,
  ) {
    final uniqueRootItems = <String, TreeItem>{};

    for (var item in filteredItems) {
      TreeItem rootItem = _getRootItem(item, filteredItems, filteredItemsParents, treeMap);
      uniqueRootItems.putIfAbsent(rootItem.id, () => rootItem);
    }

    return uniqueRootItems.values.toList();
  }
}
