import 'package:tractian_mobile_challenge/app/core/errors/exceptions.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_model.dart';
import 'package:tractian_mobile_challenge/app/core/services/rest_client.dart';

abstract class ICompaniesDatasource {
  Future<List<CompanyModel>> getCompanies();
  Future<List<CompanyLocationModel>> getCompanyLocations(String companyId);
  Future<List<CompanyAssetModel>> getCompanyAssets(String companyId);
}

class CompaniesDatasource implements ICompaniesDatasource {
  final RestClient restClient;

  CompaniesDatasource(this.restClient);

  @override
  Future<List<CompanyModel>> getCompanies() async {
    try {
      final response = await restClient.client.get('/companies');

      if (response.statusCode == 200) {
        final List list = response.data;
        return list.map((e) => CompanyModel.fromMap(e)).toList();
      } else {
        throw const LoadingCompaniesException(message: 'Erro ao carregar dados de companhias.');
      }
    } catch (e) {
      throw LoadingCompaniesException(message: e.toString());
    }
  }

  @override
  Future<List<CompanyLocationModel>> getCompanyLocations(String companyId) async {
    try {
      final response = await restClient.client.get('/companies/$companyId/locations');

      if (response.statusCode == 200) {
        final List list = response.data;
        return list.map((e) => CompanyLocationModel.fromMap(e)).toList();
      } else {
        throw const LoadingCompanyLocationsException(
            message: 'Erro ao carregar dados de locais de companhias.');
      }
    } catch (e) {
      throw LoadingCompanyLocationsException(message: e.toString());
    }
  }

  @override
  Future<List<CompanyAssetModel>> getCompanyAssets(String companyId) async {
    try {
      final response = await restClient.client.get('/companies/$companyId/assets');

      if (response.statusCode == 200) {
        final List list = response.data;
        return list.map((e) => CompanyAssetModel.fromMap(e)).toList();
      } else {
        throw const LoadingCompanyAssetsException(
            message: 'Erro ao carregar dados de ativos de companhias.');
      }
    } catch (e) {
      throw LoadingCompanyAssetsException(message: e.toString());
    }
  }
}
