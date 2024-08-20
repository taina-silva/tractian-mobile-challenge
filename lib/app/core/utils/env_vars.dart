abstract class EnvVars {
  static String get env => const String.fromEnvironment('ENV');
  static String get apiUrl => const String.fromEnvironment('API_URL');
  static bool get previewEnabled => const bool.fromEnvironment('PREVIEW_ENABLED');
}
