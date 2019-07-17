import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';

class AuthApiProvider {
  final Dio _dio;

  AuthApiProvider({@required Dio dio}) : _dio = dio {
    _dio.options.baseUrl = Url.base;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  addHeaders(Iterable<MapEntry<String, String>> headers) {
    _dio.options.headers.addEntries(headers);
  }

  Future<LoginResponseModel> login(Submitted data) async {
    Response<LoginResponseModel> response = await dio.post<LoginResponseModel>(
      Url.login,
      data: data,
    );

    print('response ------------------- $response');
    return response.data;
  }
}
