import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';
import 'package:flutter_app/src/models/model.dart';

class AuthRepository {
  final AuthApiProvider authApiProvider;

  AuthRepository({@required this.authApiProvider})
      : assert(authApiProvider != null);

  void addTokenInterceptor({
    @required SecureStorageRepository secureStorageRepository,
    @required VoidCallback onLogout,
  }) {
    authApiProvider.addTokenInterceptor(
      secureStorageRepository,
      onLogout,
    );
  }

  Future<AuthResponse> login(LoginInput data) async {
    return await authApiProvider.login(data);
  }

  Future<AuthResponse> register(RegisterInput data) async {
    return await authApiProvider.register(data);
  }

  Future<Token> verifyToken(Token data) async {
    return await authApiProvider.verifyToken(data);
  }

  Future<void> logout() async {
    return await authApiProvider.logout();
  }
}
