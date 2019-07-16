import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';

class AuthApiProvider {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  final Dio dio = Dio(options);

  setHeaders(Map<String, String> headers) {
    dio.options.headers = headers;
  }

  Future<LoginResponseModel> login(LoginInput data) async {
    Response<LoginResponseModel> response = await dio.post<LoginResponseModel>(
      Url.login,
      data: data,
    );

    return response.data;
  }
}
