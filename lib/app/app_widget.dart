import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tractian_mobile_challenge/app/core/utils/custom_colors.dart';
import 'package:tractian_mobile_challenge/app/core/utils/status_bar_theme.dart';
import 'package:tractian_mobile_challenge/app/features/home/presentation/pages/home_page.dart';
import 'package:tractian_mobile_challenge/app/features/splash/presentation/pages/splash_page.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    changeStatusBarTheme(StatusBarTheme.light, CColors.primaryColor);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
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
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: DevicePreview.appBuilder,
        home: const SplashPage(),
        routes: {
          '/home': (_) => const HomePage(),
        },
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
