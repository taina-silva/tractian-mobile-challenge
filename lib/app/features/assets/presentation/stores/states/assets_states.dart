import 'package:equatable/equatable.dart';
import 'package:tractian_mobile_challenge/app/features/assets/presentation/models/tree_item_model.dart';

sealed class GetCompanyAssetsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCompanyAssetsInitialState extends GetCompanyAssetsState {}

final class GetCompanyAssetsLoadingState extends GetCompanyAssetsState {}

final class GetCompanyAssetsSuccessState extends GetCompanyAssetsState {
  final List<TreeItem> treeRootItems;
  GetCompanyAssetsSuccessState(this.treeRootItems);
}

final class GetCompanyAssetsErrorState extends GetCompanyAssetsState {
  final String message;
  GetCompanyAssetsErrorState(this.message);
}
