import 'dart:async';

import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/auth_api.dart';
import 'package:flutter_app/src/models/model.dart';

class AuthRepository {
  final AuthApiProvider authApiProvider;

  AuthRepository({@required this.authApiProvider})
      : assert(authApiProvider != null);

  void addAuthHeader(String token) {
    authApiProvider.addHeaders([MapEntry('Authorization', 'Bearer $token')]);
  }

  Future<LoginResponse> login(LoginInput data) async {
    return await authApiProvider.login(data);
  }
}
