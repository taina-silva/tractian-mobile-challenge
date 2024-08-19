import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_mobile_challenge/app/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.add(
      ChildRoute(
        '/',
        child: (_) => const HomePage(),
        transition: TransitionType.fadeIn,
      ),
    );
  }
}
