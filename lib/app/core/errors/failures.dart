import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  final String? msg;

  const ServerFailure([
    this.msg,
  ]) : super(msg ?? "Ocorreu um erro inesperado. Tente novamente mais tarde.");

  @override
  List<Object> get props => [message];
}
