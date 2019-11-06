import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/helpers/helpers.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
class AuthApiProvider {
  final Dio _dio;

  AuthApiProvider({@required Dio dio}) : _dio = dio;

  void addHeaders(Iterable<MapEntry<String, String>> headers) {
    _dio.options.headers.addEntries(headers);
  }

  void addTokenInterceptor(
    SecureStorageRepository secureStorageRepository,
    VoidCallback onLogout,
  ) {
    _dio.interceptors.add(DioInstance.getTokenInterceptor(
      dio: _dio,
      secureStorageRepository: secureStorageRepository,
      onLogout: onLogout,
    ));
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

  Future<Token> verifyToken(Token data) async {
    final response = await _dio.post<Map<String, dynamic>>(
      Url.tokenVerify,
      data: data.toJson(),
    );

    return Token.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post<Map<String, dynamic>>(
      Url.logout,
    );
  }
}
