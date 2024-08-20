import 'package:dio/dio.dart';
import 'package:tractian_mobile_challenge/app/core/utils/env_vars.dart';

class RestClient {
  late final Dio _client;

  RestClient() {
    _client = Dio();
    _client.options.baseUrl = EnvVars.apiUrl;
  }

  Dio get client => _client;
}
