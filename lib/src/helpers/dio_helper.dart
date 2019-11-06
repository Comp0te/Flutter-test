import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_app/src/constants/constants.dart';

Object _parseAndDecode(String response) {
  return jsonDecode(response);
}

Future<Object> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class DioInstance {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
  );

  final Dio _dio;

  DioInstance() : _dio = Dio(options) {
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }

//    ..interceptors.add(LogInterceptor(
//      requestBody: true,
//      responseBody: true,
//    ));

  Dio get dio {
    if (kReleaseMode) {
      return _dio;
    }

//    configureProxy();

    return _dio;
  }

  void configureProxy() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (url) {
        return 'PROXY $urlProxyMan';
      };

      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        return Platform.isAndroid;
      };
    };
  }
}
