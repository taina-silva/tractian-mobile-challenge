import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';

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
  String? parentId;
  String name;
  TreeItemType type;
  SensorType? sensorType;
  List<TreeItem> children;
  bool isExpanded;

  TreeItem({
    required this.id,
    this.parentId,
    required this.name,
    required this.type,
    this.sensorType,
    this.children = const [],
    this.isExpanded = false,
  });

  static TreeItem getRootItemWithMatching(
    TreeItem item,
    Map<String, TreeItem> itemTreeMap,
    bool Function(TreeItem) matchingFunction,
    void Function(TreeItem) afterMatchingFunction,
  ) {
    TreeItem? parent = itemTreeMap[item.parentId];
    if (parent == null) return item;

    parent.children = parent.children.where((child) {
      return matchingFunction(child);
    }).toList();

    afterMatchingFunction(parent);

    return getRootItemWithMatching(parent, itemTreeMap, matchingFunction, afterMatchingFunction);
  }

  static bool hasDescendantWithName(TreeItem item, String name) {
    if (item.name.toLowerCase().contains(name.toLowerCase())) return true;

    for (var child in item.children) {
      if (hasDescendantWithName(child, name)) return true;
    }

    return false;
  }
}
