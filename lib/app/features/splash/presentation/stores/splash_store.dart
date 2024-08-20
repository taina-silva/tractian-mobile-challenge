import 'package:mobx/mobx.dart';
import 'package:tractian_mobile_challenge/app/features/splash/presentation/stores/states/splash_states.dart';

part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

abstract class SplashStoreBase with Store {
  @readonly
  SplashState _state = InitialState();

  @action
  Future<void> manageSplash() async {
    _state = LoadingState();

    await Future.delayed(const Duration(seconds: 3));

    _state = ToEntryState();
  }
}
