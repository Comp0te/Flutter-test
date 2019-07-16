import 'dart:async';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/data_providers/auth_api.dart';
import 'package:flutter_app/src/models/model.dart';

class LoginRepository {
  final AuthApiProvider authApiProvider;

  LoginRepository({@required this.authApiProvider})
      : assert(authApiProvider != null);

  Future<LoginResponseModel> login(Submitted data) async {
    return await authApiProvider.login(data);
  }
}