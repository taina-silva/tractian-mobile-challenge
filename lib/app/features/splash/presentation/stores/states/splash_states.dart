import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends SplashState {}

class LoadingState extends SplashState {}

class ToEntryState extends SplashState {}
