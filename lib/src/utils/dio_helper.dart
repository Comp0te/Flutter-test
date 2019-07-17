import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';

class DioInstance {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
    responseType: ResponseType.json,
  );

  final Dio _dio = Dio(options)
    ..interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

  Dio get dio => _dio;
}
