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

  AssetsStoreBase(this._repository);

  @readonly
  GetCompanyAssetsState _state = GetCompanyAssetsInitialState();

  @readonly
  Map<String, TreeItem> _originalTreeMap = {};

  @readonly
  List<TreeItem> _currentTreeRootItems = [];

  @readonly
  SensorType? _sensorTypeFilter;

  @readonly
  String? _textFilter;

  @action
  void setSensorTypeFilter(SensorType? sensorType) {
    _sensorTypeFilter = (sensorType == _sensorTypeFilter) ? null : sensorType;
    _applyFilters();
  }

  @action
  void setTextFilter(String? text) {
    _textFilter = (text == null || text.isEmpty) ? null : text;
    _applyFilters();
  }

  void _applyFilters() {
    final hasTextFilter = _textFilter != null && _textFilter!.isNotEmpty;
    final hasSensorTypeFilter = _sensorTypeFilter != null;

    if (!hasTextFilter && !hasSensorTypeFilter) {
      _currentTreeRootItems = (_state as GetCompanyAssetsSuccessState).treeRootItems;
    } else {
      _buildAssetsTreeWithFilter();
    }
  }

  @action
  Future<void> getCompanyAssets(String companyId) async {
    _state = GetCompanyAssetsLoadingState();

    final results = await Future.wait([
      _repository.getCompanyLocations(companyId),
      _repository.getCompanyAssets(companyId),
    ]);

    List<CompanyLocationModel> locations = [];
    List<CompanyAssetModel> assets = [];

    results[0].fold(
      (l) => _state = GetCompanyAssetsErrorState(l.message),
      (r) => locations = r as List<CompanyLocationModel>,
    );

    results[1].fold(
      (l) => _state = GetCompanyAssetsErrorState(l.message),
      (r) => assets = r as List<CompanyAssetModel>,
    );

    if (_state is! GetCompanyAssetsErrorState) {
      _state = GetCompanyAssetsSuccessState(_buildOriginalAssetsTree(locations, assets));
    }
  }

  @action
  List<TreeItem> _buildOriginalAssetsTree(
      List<CompanyLocationModel> locations, List<CompanyAssetModel> assets) {
    final List<TreeItem> rootItems = [];
    final Map<String, TreeItem> treeMap = {};

    for (var location in locations) {
      final treeItem = TreeItem(
        id: location.id,
        name: location.name,
        type: TreeItemType.location,
      );
      treeMap[location.id] = treeItem;
      if (location.parentId == null) rootItems.add(treeItem);
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
      if (asset.locationId == null && asset.parentId == null) rootItems.add(treeItem);
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

    _currentTreeRootItems = rootItems;
    _originalTreeMap = treeMap;

    return rootItems;
  }

  @action
  void _buildAssetsTreeWithFilter() {
    List<TreeItem> filteredItems = [];
    List<TreeItem> rootItems = [];

    for (var item in _originalTreeMap.values) {
      final matchesSensorType = _sensorTypeFilter == null || item.sensorType == _sensorTypeFilter;
      final matchesTextFilter = _textFilter == null ||
          _textFilter!.isEmpty ||
          item.name.toLowerCase().contains(_textFilter!.toLowerCase());
      if (matchesSensorType && matchesTextFilter) filteredItems.add(item);
    }

    TreeItem getRootItem(TreeItem currentItem, List<TreeItem> path) {
      if (currentItem.parentId == null) return currentItem;
      final parent = _originalTreeMap[currentItem.parentId];
      if (parent != null) {
        parent.children = List.from(parent.children)
          ..removeWhere((TreeItem item) => !filteredItems.contains(item) && !path.contains(item));
        return getRootItem(parent, [...path, parent]);
      }
      return currentItem;
    }

    for (var item in filteredItems) {
      TreeItem rootItem = getRootItem(item, [item]);
      if (!rootItems.contains(rootItem)) rootItems.add(rootItem);
    }

    _currentTreeRootItems = rootItems;
  }
}
