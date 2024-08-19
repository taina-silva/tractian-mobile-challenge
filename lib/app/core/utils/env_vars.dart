abstract class EnvVars {
  static String get env => const String.fromEnvironment('ENV');
  static String get baseURL => const String.fromEnvironment('BASE_URL');
  static bool get previewEnabled =>
      const bool.fromEnvironment('PREVIEW_ENABLED');
}
