import 'package:dio/dio.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';

class AuthApiProvider {
  static BaseOptions options = BaseOptions(
    baseUrl: Url.base,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  static InterceptorsWrapper logger = InterceptorsWrapper(
      onRequest: (RequestOptions options) {
        // Do something before request is sent
        return options; //continue
        // If you want to resolve the request with some custom data，
        // you can return a `Response` object or return `dio.resolve(data)`.
        // If you want to reject the request with a error message,
        // you can return a `DioError` object or return `dio.reject(errMsg)`
      },
      onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      },
      onError: (DioError e) {
        // Do something with response error
        return e; //continue
      }
  );

  Dio dio;

  AuthApiProvider({@required Dio dio}) {
    this.dio = dio;
    this.dio.interceptors.add(logger);
  }
//      : assert(dio != null),
//        dio.interceptors.add(logger);

//  interceptors.add(element);

  serInterceptors() {
    dio.interceptors.add(logger);
  }

  setHeaders(Map<String, String> headers) {
    dio.options.headers = headers;
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
