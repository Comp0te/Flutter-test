import 'package:dio/dio.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';

@immutable
class AuthApiProvider {
  final Dio _dio;

  AuthApiProvider({@required Dio dio}) : _dio = dio;

  void addHeaders(Iterable<MapEntry<String, String>> headers) {
    _dio.options.headers.addEntries(headers);
  }

  Future<AuthResponse> login(LoginInput data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.login,
      data: data.toJson(),
    );

    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> register(RegisterInput data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.register,
      data: data.toJson(),
    );

    return AuthResponse.fromJson(response.data);
  }
}
