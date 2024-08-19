import 'package:flutter/material.dart';

abstract class CColors {
  const CColors._();

  static const primaryBackground = Color.fromRGBO(248, 248, 248, 1);
  static const secondaryBackground = Color.fromRGBO(251, 246, 241, 1);

  static const primaryColor = Color.fromRGBO(23, 25, 45, 1);
  static const secondaryColor = Color.fromRGBO(33, 136, 255, 1);

  static const neutral0 = Color.fromRGBO(255, 255, 255, 1);
  static const neutral100 = Color.fromRGBO(250, 250, 250, 1);
  static const neutral200 = Color.fromRGBO(242, 242, 242, 1);
  static const neutral250 = Color.fromRGBO(243, 245, 247, 1);
  static const neutral300 = Color.fromRGBO(239, 239, 239, 1);
  static const neutral350 = Color.fromRGBO(229, 229, 232, 1);
  static const neutral400 = Color.fromRGBO(209, 209, 209, 1);
  static const neutral500 = Color.fromRGBO(182, 182, 182, 1);
  static const neutral550 = Color.fromRGBO(160, 160, 160, 1);
  static const neutral600 = Color.fromRGBO(148, 148, 148, 1);
  static const neutral650 = Color.fromRGBO(136, 136, 136, 1);
  static const neutral700 = Color.fromRGBO(104, 104, 104, 1);
  static const neutral800 = Color.fromRGBO(53, 53, 53, 1);
  static const neutral900 = Color.fromRGBO(0, 0, 0, 1);

  static const error100 = Color.fromRGBO(212, 170, 168, 1);
  static const error200 = Color.fromRGBO(195, 125, 125, 1);
  static const error300 = Color.fromRGBO(189, 92, 92, 1);
  static const error400 = Color.fromRGBO(185, 68, 62, 1);
  static const error500 = Color.fromRGBO(191, 36, 34, 1);

  static const warning100 = Color.fromRGBO(255, 235, 211, 1);
  static const warning200 = Color.fromRGBO(255, 242, 226, 1);
  static const warning300 = Color.fromRGBO(255, 245, 234, 1);
  static const warning400 = Color.fromRGBO(255, 215, 157, 1);
  static const warning500 = Color.fromRGBO(225, 184, 120, 1);

  static const success100 = Color.fromRGBO(226, 241, 234, 1);
  static const success200 = Color.fromRGBO(236, 246, 241, 1);
  static const success300 = Color.fromRGBO(241, 248, 245, 1);
  static const success400 = Color.fromRGBO(174, 233, 209, 1);
  static const success500 = Color.fromRGBO(149, 201, 180, 1);

  static const info100 = Color.fromRGBO(79, 195, 247, 1);
  static const info200 = Color.fromRGBO(41, 182, 246, 1);
  static const info300 = Color.fromRGBO(2, 136, 209, 1);
}

MaterialColor getMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: Color.fromRGBO(color.red, color.blue, color.green, 0.1),
    100: Color.fromRGBO(color.red, color.blue, color.green, 0.2),
    200: Color.fromRGBO(color.red, color.blue, color.green, 0.3),
    300: Color.fromRGBO(color.red, color.blue, color.green, 0.4),
    400: Color.fromRGBO(color.red, color.blue, color.green, 0.5),
    500: Color.fromRGBO(color.red, color.blue, color.green, 0.6),
    600: Color.fromRGBO(color.red, color.blue, color.green, 0.7),
    700: Color.fromRGBO(color.red, color.blue, color.green, 0.8),
    800: Color.fromRGBO(color.red, color.blue, color.green, 0.9),
    900: Color.fromRGBO(color.red, color.blue, color.green, 1),
  });
}
