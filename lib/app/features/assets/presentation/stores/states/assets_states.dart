import 'package:equatable/equatable.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';

sealed class GetCompanyAssetsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCompanyAssetsInitialState extends GetCompanyAssetsState {}

final class GetCompanyAssetsLoadingState extends GetCompanyAssetsState {}

final class GetCompanyAssetsSuccessState extends GetCompanyAssetsState {
  final List<CompanyLocationModel> locations;
  final List<CompanyAssetModel> assets;
  GetCompanyAssetsSuccessState(this.locations, this.assets);
}

final class GetCompanyAssetsErrorState extends GetCompanyAssetsState {
  final String message;
  GetCompanyAssetsErrorState(this.message);
}
