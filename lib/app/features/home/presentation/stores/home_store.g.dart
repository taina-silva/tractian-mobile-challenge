// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$companiesAtom =
      Atom(name: 'HomeStoreBase.companies', context: context);

  @override
  ObservableList<CompanyModel> get companies {
    _$companiesAtom.reportRead();
    return super.companies;
  }

  @override
  set companies(ObservableList<CompanyModel> value) {
    _$companiesAtom.reportWrite(value, super.companies, () {
      super.companies = value;
    });
  }

  late final _$_fetchCompaniesStateAtom =
      Atom(name: 'HomeStoreBase._fetchCompaniesState', context: context);

  FetchCompaniesState get fetchCompaniesState {
    _$_fetchCompaniesStateAtom.reportRead();
    return super._fetchCompaniesState;
  }

  @override
  FetchCompaniesState get _fetchCompaniesState => fetchCompaniesState;

  @override
  set _fetchCompaniesState(FetchCompaniesState value) {
    _$_fetchCompaniesStateAtom.reportWrite(value, super._fetchCompaniesState,
        () {
      super._fetchCompaniesState = value;
    });
  }

  late final _$_fetchCompanyPropertiesStateAtom = Atom(
      name: 'HomeStoreBase._fetchCompanyPropertiesState', context: context);

  FetchCompanyPropertiesState get fetchCompanyPropertiesState {
    _$_fetchCompanyPropertiesStateAtom.reportRead();
    return super._fetchCompanyPropertiesState;
  }

  @override
  FetchCompanyPropertiesState get _fetchCompanyPropertiesState =>
      fetchCompanyPropertiesState;

  @override
  set _fetchCompanyPropertiesState(FetchCompanyPropertiesState value) {
    _$_fetchCompanyPropertiesStateAtom
        .reportWrite(value, super._fetchCompanyPropertiesState, () {
      super._fetchCompanyPropertiesState = value;
    });
  }

  late final _$fetchCompaniesAsyncAction =
      AsyncAction('HomeStoreBase.fetchCompanies', context: context);

  @override
  Future<void> fetchCompanies() {
    return _$fetchCompaniesAsyncAction.run(() => super.fetchCompanies());
  }

  late final _$fetchCompanyPropertiesAsyncAction =
      AsyncAction('HomeStoreBase.fetchCompanyProperties', context: context);

  @override
  Future<void> fetchCompanyProperties(String companyId) {
    return _$fetchCompanyPropertiesAsyncAction
        .run(() => super.fetchCompanyProperties(companyId));
  }

  @override
  String toString() {
    return '''
companies: ${companies}
    ''';
  }
}
