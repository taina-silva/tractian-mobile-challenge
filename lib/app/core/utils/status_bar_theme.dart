import 'package:flutter/services.dart';

enum StatusBarTheme { light, dark }

void changeStatusBarTheme(StatusBarTheme theme, Color color) {
  if (theme == StatusBarTheme.light) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: color,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: color,
    ));
  }
}
