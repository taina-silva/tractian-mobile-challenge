import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

class ComputeOriginalTreeRequest extends Equatable {
  final List<CompanyLocationModel> locations;
  final List<CompanyAssetModel> assets;

  const ComputeOriginalTreeRequest(this.locations, this.assets);

  @override
  List<Object?> get props => [locations, assets];
}

class ComputeOriginalTreeResponse extends Equatable {
  final List<TreeItem> treeRootItems;

  const ComputeOriginalTreeResponse(this.treeRootItems);

  @override
  List<Object?> get props => [treeRootItems];
}

Future<ComputeOriginalTreeResponse> buildOriginalTree(ComputeOriginalTreeRequest request) async {
  try {
    final result = await compute<ComputeOriginalTreeRequest, ComputeOriginalTreeResponse>(
      computeOriginalTree,
      request,
    );
    return result;
  } catch (error) {
    throw Exception(error);
  }
}

ComputeOriginalTreeResponse computeOriginalTree(ComputeOriginalTreeRequest params) {
  List<CompanyLocationModel> locations = params.locations;
  List<CompanyAssetModel> assets = params.assets;
  Map<String, TreeItem> treeMap = {};
  List<TreeItem> treeRootItems = [];

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
        treeItem!.parent = parent;
        parent.children = List.from(parent.children)..add(treeItem);
      }
    }
  }

  for (var asset in assets) {
    final treeItem = TreeItem(
      id: asset.id,
      name: asset.name,
      type: asset.sensorType != null ? TreeItemType.component : TreeItemType.asset,
      sensorType: asset.sensorType != null ? SensorType.fromStr(asset.sensorType!) : null,
    );
    treeMap[asset.id] = treeItem;
    if (asset.locationId == null && asset.parentId == null) {
      treeRootItems.add(treeItem);
    }
  }

  for (var asset in assets) {
    final treeItem = treeMap[asset.id];
    final parent = asset.locationId != null ? treeMap[asset.locationId] : treeMap[asset.parentId];
    if (parent != null) {
      treeItem!.parent = parent;
      parent.children = List.from(parent.children)..add(treeItem);
    }
  }

  return ComputeOriginalTreeResponse(treeRootItems);
}
