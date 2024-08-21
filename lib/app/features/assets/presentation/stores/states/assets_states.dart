import 'package:equatable/equatable.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_asset_model.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_location_model.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

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

sealed class BuildTreeState extends Equatable {
  @override
  List<Object> get props => [];
}

final class BuildTreeInitialState extends BuildTreeState {}

final class BuildTreeLoadingState extends BuildTreeState {}

final class BuildTreeSuccessState extends BuildTreeState {
  final Map<String, TreeItem> treeMap;
  final List<TreeItem> treeRootItems;
  BuildTreeSuccessState(this.treeMap, this.treeRootItems); 
}

final class BuildTreeErrorState extends BuildTreeState {
  final String message;
  BuildTreeErrorState(this.message);
}
