import 'package:equatable/equatable.dart';
import 'package:tractian_mobile_challenge/app/core/infra/models/company_model.dart';

sealed class GetCompaniesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class GetCompaniesInitialState extends GetCompaniesState {}

final class GetCompaniesLoadingState extends GetCompaniesState {}

final class GetCompaniesSuccessState extends GetCompaniesState {
  final List<CompanyModel> companies;
  GetCompaniesSuccessState(this.companies);
}

final class GetCompaniesErrorState extends GetCompaniesState {
  final String message;
  GetCompaniesErrorState(this.message);
}
