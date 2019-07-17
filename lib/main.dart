import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';
import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final SecureStorageRepository _secureStorageRepository =
      SecureStorageRepository(
    storage: SecureStorageProvider(secureStorage: FlutterSecureStorage()),
  );
  final AuthRepository _authRepository = AuthRepository(
    authApiProvider: AuthApiProvider(dio: Dio()),
  );

  runApp(
    BlocProvider(
      builder: (context) => AuthBloc(
            secureStorageRepository: _secureStorageRepository,
            authRepository: _authRepository,
          )..dispatch(AppStarted()),
      child: App(
        secureStorageRepository: _secureStorageRepository,
        authRepository: _authRepository,
      ),
    ),
  );
}
