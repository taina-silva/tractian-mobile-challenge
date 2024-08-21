// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on AssetsStoreBase, Store {
  late final _$_stateAtom =
      Atom(name: 'AssetsStoreBase._state', context: context);

  GetCompanyAssetsState get state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  GetCompanyAssetsState get _state => state;

  @override
  set _state(GetCompanyAssetsState value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  late final _$_originalTreeMapAtom =
      Atom(name: 'AssetsStoreBase._originalTreeMap', context: context);

  Map<String, TreeItem> get originalTreeMap {
    _$_originalTreeMapAtom.reportRead();
    return super._originalTreeMap;
  }

  @override
  Map<String, TreeItem> get _originalTreeMap => originalTreeMap;

  @override
  set _originalTreeMap(Map<String, TreeItem> value) {
    _$_originalTreeMapAtom.reportWrite(value, super._originalTreeMap, () {
      super._originalTreeMap = value;
    });
  }

  late final _$_currentTreeRootItemsAtom =
      Atom(name: 'AssetsStoreBase._currentTreeRootItems', context: context);

  List<TreeItem> get currentTreeRootItems {
    _$_currentTreeRootItemsAtom.reportRead();
    return super._currentTreeRootItems;
  }

  @override
  List<TreeItem> get _currentTreeRootItems => currentTreeRootItems;

  @override
  set _currentTreeRootItems(List<TreeItem> value) {
    _$_currentTreeRootItemsAtom.reportWrite(value, super._currentTreeRootItems,
        () {
      super._currentTreeRootItems = value;
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
  Map<String, TreeItem> _buildOriginalAssetsTree(
      {List<CompanyLocationModel>? locationsList,
      List<CompanyAssetModel>? assetsList}) {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase._buildOriginalAssetsTree');
    try {
      return super._buildOriginalAssetsTree(
          locationsList: locationsList, assetsList: assetsList);
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
