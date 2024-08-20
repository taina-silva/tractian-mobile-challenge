import 'package:equatable/equatable.dart';

class LoadingCompaniesException extends Equatable implements Exception {
  final String? message;

  const LoadingCompaniesException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class LoadingCompanyLocationsException extends Equatable implements Exception {
  final String? message;

  const LoadingCompanyLocationsException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}

class LoadingCompanyAssetsException extends Equatable implements Exception {
  final String? message;

  const LoadingCompanyAssetsException({this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool get stringify => true;
}
