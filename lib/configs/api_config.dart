import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Configuration Service for OPENTDB API
class ApiConfigService {
  Dio dio = Dio();

  /// make a request
  Dio $Request() {
    dio.options.baseUrl = baseUrl().toString();
    dio.options.headers = setHeaders();
    debugPrint(dio.toString());
    return dio;
  }

  /// Get link to website home
  String baseUrl() {
    return 'https://opentdb.com/';
  }

  /// Set Headers
  Map<String, dynamic> setHeaders() {
    Map<String, dynamic> header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    debugPrint("user header $header");
    return header;
  }
}
