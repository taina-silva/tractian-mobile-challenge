import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/repositories/companies_repository.dart';
import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/stores/states/assets_states.dart';

part 'assets_store.g.dart';

class AssetsStore = AssetsStoreBase with _$AssetsStore;

abstract class AssetsStoreBase with Store {
  final ICompaniesRepository _repository;

  AssetsStoreBase(this._repository);

  @readonly
  GetCompanyAssetsState _state = GetCompanyAssetsInitialState();

  @observable
  SensorType? sensorTypeFilter;

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
      _state = GetCompanyAssetsSuccessState(locations, assets);
    }
  }

  @computed
  List<TreeItem> get assetsTree {
    if (_state is! GetCompanyAssetsSuccessState) return [];

    final List<CompanyLocationModel> locations =
        List.from((_state as GetCompanyAssetsSuccessState).locations);
    final List<CompanyAssetModel> assets =
        List.from((_state as GetCompanyAssetsSuccessState).assets);

    final Map<String, TreeItem> treeMap = {};
    final List<TreeItem> rootItems = [];

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
        if (parent != null) parent.children = List.from(parent.children)..add(treeItem!);
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
      if (parent != null) parent.children = List.from(parent.children)..add(treeItem!);
    }

    return rootItems;
  }
}

enum TreeItemType { location, asset, component }

enum SensorType { energy, vibration }

extension TreeItemTypeExtension on TreeItemType {
  String get icon {
    switch (this) {
      case TreeItemType.location:
        return '${Assets.icons}/location.png';
      case TreeItemType.asset:
        return '${Assets.icons}/asset.png';
      case TreeItemType.component:
        return '${Assets.icons}/component.png';
    }
  }
}

extension SensorTypeExtension on SensorType {
  String get icon {
    switch (this) {
      case SensorType.energy:
        return '${Assets.icons}/energy.png';
      case SensorType.vibration:
        return '${Assets.icons}/vibration.png';
    }
  }
}

class TreeItem {
  String id;
  String name;
  TreeItemType type;
  SensorType? sensorType;
  List<TreeItem> children;
  bool isExpanded;

  TreeItem({
    required this.id,
    required this.name,
    required this.type,
    this.sensorType,
    this.children = const [],
    this.isExpanded = false,
  });
}
