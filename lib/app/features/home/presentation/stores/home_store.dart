import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/repositories/companies_repository.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/stores/states/home_states.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ICompaniesRepository _repository;

  HomeStoreBase(this._repository);

  @observable
  ObservableList<CompanyModel> companies = ObservableList<CompanyModel>();

  @readonly
  FetchCompaniesState _fetchCompaniesState = FetchCompaniesInitialState();

  @readonly
  FetchCompanyPropertiesState _fetchCompanyPropertiesState = FetchCompanyPropertiesInitialState();

  @action
  Future<void> fetchCompanies() async {
    _fetchCompaniesState = FetchCompaniesLoadingState();

    final r = await _repository.getCompanies();

    r.fold(
      (l) => _fetchCompaniesState = FetchCompaniesErrorState(l.message),
      (r) {
        companies = r.asObservable();
        _fetchCompaniesState = FetchCompaniesSuccessState();
      },
    );
  }

  @action
  Future<void> fetchCompanyProperties(String companyId) async {
    _fetchCompanyPropertiesState = FetchCompanyPropertiesLoadingState();

    CompanyModel company = companies.firstWhere((element) => element.id == companyId);
    if (company.locations.isNotEmpty && company.assets.isNotEmpty) {
      _fetchCompanyPropertiesState = FetchCompanyPropertiesSuccessState();
      return;
    }

    bool hasError = false;

    if (company.locations.isEmpty) {
      final r = await _repository.getCompanyLocations(companyId);
      r.fold(
        (l) => hasError = true,
        (r) => company.locations = r,
      );
    }

    if (company.assets.isEmpty) {
      final r = await _repository.getCompanyAssets(companyId);
      r.fold(
        (l) => hasError = true,
        (r) => company.assets = r,
      );
    }

    _fetchCompanyPropertiesState = hasError
        ? FetchCompanyPropertiesErrorState('Erro ao buscar assets da companhia!')
        : FetchCompanyPropertiesSuccessState();
  }

  List<CompanyLocationModel> companyLocations(String companyId) {
    return companies.firstWhere((element) => element.id == companyId).locations;
  }

  List<CompanyAssetModel> companyAssets(String companyId) {
    return companies.firstWhere((element) => element.id == companyId).assets;
  }
}
