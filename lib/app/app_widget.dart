import 'dart:async';
import 'dart:developer' as dev;

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/core/utils/status_bar_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    Modular.to.addListener(navigationListener);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    Modular.to.removeListener(navigationListener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void navigationListener() {
    if (!kReleaseMode) {
      dev.log('[NAV]: ${Modular.to.path}');
    }

    changeStatusBarTheme(StatusBarTheme.light, CColors.primaryBackground);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp.router(
        title: 'Tractian Mobile Challenge',
        debugShowCheckedModeBanner: false,
        scrollBehavior: const CustomScrollBehavior(),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: getMaterialColor(CColors.primaryBackground),
          fontFamily: 'K2D',
        ),
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        supportedLocales: const [Locale('pt', 'BR')],
        builder: DevicePreview.appBuilder,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
