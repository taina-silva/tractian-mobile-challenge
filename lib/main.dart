import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/app/app_widget.dart';
import 'package:tractian_mobile_challenge/app/core/services/app_providers.dart';
import 'package:tractian_mobile_challenge/app/core/utils/env_vars.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppProviders().setup();

  runApp(
    DevicePreview(
      enabled: EnvVars.previewEnabled,
      builder: (_) => const AppWidget(),
    ),
  );
}
