import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

part 'assets_store.g.dart';

class AssetsStore = AssetsStoreBase with _$AssetsStore;

abstract class AssetsStoreBase with Store {
  @readonly
  String? _companyId;

  @observable
  List<TreeItem> originalTreeRootItems = [];

  @observable
  List<TreeItem> treeRootItems = [];

  @readonly
  SensorType? _sensorFilter;

  @readonly
  String? _textFilter;

  @action
  void setSensorTypeFilter(SensorType? sensorType) {
    _sensorFilter = (sensorType == _sensorFilter) ? null : sensorType;
  }

  @action
  void setTextFilter(String? text) {
    _textFilter = (text == null || text.isEmpty) ? null : text;
  }

  @action
  bool setCompanyId(String companyId) {
    if (_companyId != companyId) {
      _companyId = companyId;

      originalTreeRootItems = [];
      treeRootItems = [];

      return true;
    }

    return false;
  }
}
