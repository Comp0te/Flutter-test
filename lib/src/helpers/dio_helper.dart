import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_app/src/constants/constants.dart';

class DioInstance {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
  );

  final Dio _dio = Dio(options);
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
