import 'package:equatable/equatable.dart';

sealed class FetchCompaniesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchCompaniesInitialState extends FetchCompaniesState {}

final class FetchCompaniesLoadingState extends FetchCompaniesState {}

final class FetchCompaniesSuccessState extends FetchCompaniesState {}

final class FetchCompaniesErrorState extends FetchCompaniesState {
  final String message;
  FetchCompaniesErrorState(this.message);
}

sealed class FetchCompanyPropertiesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchCompanyPropertiesInitialState extends FetchCompanyPropertiesState {}

final class FetchCompanyPropertiesLoadingState extends FetchCompanyPropertiesState {}

final class FetchCompanyPropertiesSuccessState extends FetchCompanyPropertiesState {}

final class FetchCompanyPropertiesErrorState extends FetchCompanyPropertiesState {
  final String message;
  FetchCompanyPropertiesErrorState(this.message);
}
