import 'package:fpdart/fpdart.dart';
import 'package:tractian_mobile_challenge/app/core/errors/exceptions.dart';
import 'package:tractian_mobile_challenge/app/core/errors/failures.dart';
import 'package:tractian_mobile_challenge/app/core/infra/datasources/companies_datasource.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_model.dart';

abstract class ICompaniesRepository {
  Future<Either<Failure, List<CompanyModel>>> getCompanies();
  Future<Either<Failure, List<CompanyLocationModel>>> getCompanyLocations(String companyId);
  Future<Either<Failure, List<CompanyAssetModel>>> getCompanyAssets(String companyId);
}

class CompaniesRepository implements ICompaniesRepository {
  CompaniesRepository(
    ICompaniesDatasource repository,
  ) : _datasource = repository;

  final ICompaniesDatasource _datasource;

  @override
  Future<Either<Failure, List<CompanyModel>>> getCompanies() async {
    try {
      List<CompanyModel> result = await _datasource.getCompanies();
      return Right(result);
    } on LoadingCompaniesException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CompanyLocationModel>>> getCompanyLocations(String companyId) async {
    try {
      List<CompanyLocationModel> result = await _datasource.getCompanyLocations(companyId);
      return Right(result);
    } on LoadingCompanyLocationsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CompanyAssetModel>>> getCompanyAssets(String companyId) async {
    try {
      List<CompanyAssetModel> result = await _datasource.getCompanyAssets(companyId);
      return Right(result);
    } on LoadingCompanyAssetsException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
