import 'package:tractian_mobile_challenge/app/core/utils/constants.dart';

enum TreeItemType {
  location,
  asset,
  component;

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

enum SensorType {
  energy,
  vibration;

  String get icon {
    switch (this) {
      case SensorType.energy:
        return '${Assets.icons}/energy.png';
      case SensorType.vibration:
        return '${Assets.icons}/vibration.png';
    }
  }

  static SensorType fromStr(String str) {
    switch (str) {
      case 'energy':
        return SensorType.energy;
      case 'vibration':
        return SensorType.vibration;
      default:
        throw ArgumentError('Invalid sensor type: $str');
    }
  }
}

class TreeItem {
  String id;
  TreeItem? parent;
  String name;
  TreeItemType type;
  SensorType? sensorType;
  List<TreeItem> children;
  bool isExpanded;
  bool isShown;

  TreeItem({
    required this.id,
    this.parent,
    required this.name,
    required this.type,
    this.sensorType,
    this.children = const [],
    this.isExpanded = false,
    this.isShown = true,
  });
}
