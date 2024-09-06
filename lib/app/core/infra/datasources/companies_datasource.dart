import 'package:flutter/foundation.dart';
import 'package:tractian_mobile_challenge/app/core/errors/exceptions.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_model.dart';
import 'package:tractian_mobile_challenge/app/core/services/rest_client.dart';
import 'package:tractian_mobile_challenge/app/core/utils/parsers.dart';

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
        final companies = await compute<ComputeParams<CompanyModel>, List<CompanyModel>>(
          parseItemsInBackground,
          ComputeParams<CompanyModel>(response.data, (map) => CompanyModel.fromMap(map)),
        );
        return companies;
      } else {
        throw const LoadingCompaniesException();
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
        final locations =
            await compute<ComputeParams<CompanyLocationModel>, List<CompanyLocationModel>>(
          parseItemsInBackground,
          ComputeParams<CompanyLocationModel>(
              response.data, (map) => CompanyLocationModel.fromMap(map)),
        );
        return locations;
      } else {
        throw const LoadingCompanyLocationsException();
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
        final assets = await compute<ComputeParams<CompanyAssetModel>, List<CompanyAssetModel>>(
          parseItemsInBackground,
          ComputeParams<CompanyAssetModel>(response.data, (map) => CompanyAssetModel.fromMap(map)),
        );
        return assets;
      } else {
        throw const LoadingCompanyAssetsException();
      }
    } catch (e) {
      throw LoadingCompanyAssetsException(message: e.toString());
    }
  }
}
