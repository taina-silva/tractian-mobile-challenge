// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on AssetsStoreBase, Store {
  late final _$_getCompanyAssetsStateAtom =
      Atom(name: 'AssetsStoreBase._getCompanyAssetsState', context: context);

  GetCompanyAssetsState get getCompanyAssetsState {
    _$_getCompanyAssetsStateAtom.reportRead();
    return super._getCompanyAssetsState;
  }

  @override
  GetCompanyAssetsState get _getCompanyAssetsState => getCompanyAssetsState;

  @override
  set _getCompanyAssetsState(GetCompanyAssetsState value) {
    _$_getCompanyAssetsStateAtom
        .reportWrite(value, super._getCompanyAssetsState, () {
      super._getCompanyAssetsState = value;
    });
  }

  late final _$_buildTreeStateAtom =
      Atom(name: 'AssetsStoreBase._buildTreeState', context: context);

  BuildTreeState get buildTreeState {
    _$_buildTreeStateAtom.reportRead();
    return super._buildTreeState;
  }

  @override
  BuildTreeState get _buildTreeState => buildTreeState;

  @override
  set _buildTreeState(BuildTreeState value) {
    _$_buildTreeStateAtom.reportWrite(value, super._buildTreeState, () {
      super._buildTreeState = value;
    });
  }

  late final _$_sensorTypeFilterAtom =
      Atom(name: 'AssetsStoreBase._sensorTypeFilter', context: context);

  SensorType? get sensorTypeFilter {
    _$_sensorTypeFilterAtom.reportRead();
    return super._sensorTypeFilter;
  }

  @override
  SensorType? get _sensorTypeFilter => sensorTypeFilter;

  @override
  set _sensorTypeFilter(SensorType? value) {
    _$_sensorTypeFilterAtom.reportWrite(value, super._sensorTypeFilter, () {
      super._sensorTypeFilter = value;
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

  late final _$getCompanyAssetsAsyncAction =
      AsyncAction('AssetsStoreBase.getCompanyAssets', context: context);

  @override
  Future<void> getCompanyAssets(String companyId) {
    return _$getCompanyAssetsAsyncAction
        .run(() => super.getCompanyAssets(companyId));
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
  void _buildOriginalAssetsTree() {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase._buildOriginalAssetsTree');
    try {
      return super._buildOriginalAssetsTree();
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _buildAssetsTreeWithFilter() {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase._buildAssetsTreeWithFilter');
    try {
      return super._buildAssetsTreeWithFilter();
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
