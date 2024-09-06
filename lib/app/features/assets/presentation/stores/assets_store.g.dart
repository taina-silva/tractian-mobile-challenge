// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on AssetsStoreBase, Store {
  late final _$_companyIdAtom =
      Atom(name: 'AssetsStoreBase._companyId', context: context);

  String? get companyId {
    _$_companyIdAtom.reportRead();
    return super._companyId;
  }

  @override
  String? get _companyId => companyId;

  @override
  set _companyId(String? value) {
    _$_companyIdAtom.reportWrite(value, super._companyId, () {
      super._companyId = value;
    });
  }

  late final _$originalTreeRootItemsAtom =
      Atom(name: 'AssetsStoreBase.originalTreeRootItems', context: context);

  @override
  List<TreeItem> get originalTreeRootItems {
    _$originalTreeRootItemsAtom.reportRead();
    return super.originalTreeRootItems;
  }

  @override
  set originalTreeRootItems(List<TreeItem> value) {
    _$originalTreeRootItemsAtom.reportWrite(value, super.originalTreeRootItems,
        () {
      super.originalTreeRootItems = value;
    });
  }

  late final _$treeRootItemsAtom =
      Atom(name: 'AssetsStoreBase.treeRootItems', context: context);

  @override
  List<TreeItem> get treeRootItems {
    _$treeRootItemsAtom.reportRead();
    return super.treeRootItems;
  }

  @override
  set treeRootItems(List<TreeItem> value) {
    _$treeRootItemsAtom.reportWrite(value, super.treeRootItems, () {
      super.treeRootItems = value;
    });
  }

  late final _$_sensorFilterAtom =
      Atom(name: 'AssetsStoreBase._sensorFilter', context: context);

  SensorType? get sensorFilter {
    _$_sensorFilterAtom.reportRead();
    return super._sensorFilter;
  }

  @override
  SensorType? get _sensorFilter => sensorFilter;

  @override
  set _sensorFilter(SensorType? value) {
    _$_sensorFilterAtom.reportWrite(value, super._sensorFilter, () {
      super._sensorFilter = value;
    });
  }

  late final _$_textFilterAtom =
      Atom(name: 'AssetsStoreBase._textFilter', context: context);

  String? get textFilter {
    _$_textFilterAtom.reportRead();
    return super._textFilter;
  }

  @override
  String? get _textFilter => textFilter;

  @override
  set _textFilter(String? value) {
    _$_textFilterAtom.reportWrite(value, super._textFilter, () {
      super._textFilter = value;
    });
  }

  late final _$AssetsStoreBaseActionController =
      ActionController(name: 'AssetsStoreBase', context: context);

  @override
  void setSensorTypeFilter(SensorType? sensorType) {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase.setSensorTypeFilter');
    try {
      return super.setSensorTypeFilter(sensorType);
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTextFilter(String? text) {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase.setTextFilter');
    try {
      return super.setTextFilter(text);
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool setCompanyId(String companyId) {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase.setCompanyId');
    try {
      return super.setCompanyId(companyId);
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
originalTreeRootItems: ${originalTreeRootItems},
treeRootItems: ${treeRootItems}
    ''';
  }
}
