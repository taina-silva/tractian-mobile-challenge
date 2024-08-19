import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_mobile_challenge/app/modules/home/home_module.dart';
import 'package:tractian_mobile_challenge/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:tractian_mobile_challenge/app/modules/splash/presentation/stores/splash_store.dart';

class SplashModule extends Module {
  @override
  void binds(Injector i) {
    i.addInstance(SplashStore());
  }

  @override
  void routes(RouteManager r) {
    r.add(
      ChildRoute(
        '/',
        child: (_) => const SplashPage(),
        transition: TransitionType.fadeIn,
      ),
    );
    r.add(
      ModuleRoute(
        '/home',
        module: HomeModule(),
        transition: TransitionType.fadeIn,
      ),
    );
  }
}
