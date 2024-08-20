// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on AssetsStoreBase, Store {
  Computed<List<TreeItem>>? _$assetsTreeComputed;

  @override
  List<TreeItem> get assetsTree =>
      (_$assetsTreeComputed ??= Computed<List<TreeItem>>(() => super.assetsTree,
              name: 'AssetsStoreBase.assetsTree'))
          .value;

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

  late final _$sensorTypeFilterAtom =
      Atom(name: 'AssetsStoreBase.sensorTypeFilter', context: context);

  @override
  SensorType? get sensorTypeFilter {
    _$sensorTypeFilterAtom.reportRead();
    return super.sensorTypeFilter;
  }

  @override
  set sensorTypeFilter(SensorType? value) {
    _$sensorTypeFilterAtom.reportWrite(value, super.sensorTypeFilter, () {
      super.sensorTypeFilter = value;
    });
  }

  late final _$getCompanyAssetsAsyncAction =
      AsyncAction('AssetsStoreBase.getCompanyAssets', context: context);

  @override
  Future<void> getCompanyAssets(String companyId) {
    return _$getCompanyAssetsAsyncAction
        .run(() => super.getCompanyAssets(companyId));
  }

  @override
  String toString() {
    return '''
sensorTypeFilter: ${sensorTypeFilter},
assetsTree: ${assetsTree}
    ''';
  }
}
