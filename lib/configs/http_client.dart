import 'package:flutter/material.dart';
import 'api_config.dart';

/// Create a client connection
class HttpClient {
  final api = ApiConfigService();
  final String resource;

  /// Create a client connection
  HttpClient({required this.resource});

  /// get resource data
  Future get({String url = '', dynamic data}) async {
    var response = await api.$Request().get('$resource/$url', queryParameters: data);
    _printOut(response);
    return response.data;
  }

  // print data
  void _printOut(dynamic object) {
    debugPrint('Response status = ${object.statusCode}');
    debugPrint('Response Message = ${object.statusMessage}');
    debugPrint('Real url= ${object.realUri}');
    debugPrint('Data = ' + object.data.toString());
  }
}
