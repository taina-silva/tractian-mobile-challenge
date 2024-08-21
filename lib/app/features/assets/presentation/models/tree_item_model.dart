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

  TreeItem clone() {
    return TreeItem(
      id: id,
      parentId: parentId,
      name: name,
      type: type,
      sensorType: sensorType,
      children: children.map((child) => child.clone()).toList(),
      isExpanded: isExpanded,
    );
  }
}
