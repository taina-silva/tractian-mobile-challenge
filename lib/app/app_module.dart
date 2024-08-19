import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {
    // i.registerSingleton<ApiService>(ApiService());
  }

  @override
  void routes(RouteManager r) {
    // r.define('/', child: (_, __) => const SplashPage());
  }
}
