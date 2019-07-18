import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_app/src/utils/dio_helper.dart';
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
    authApiProvider: AuthApiProvider(dio: DioInstance().dio),
  );

  runApp(
    BlocProvider(
      builder: (context) => AuthBloc(
            secureStorageRepository: _secureStorageRepository,
            authRepository: _authRepository,
          )..dispatch(AppStarted()),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(builder: (context) {
            return _authRepository;
          }),
          RepositoryProvider<SecureStorageRepository>(builder: (context) {
            return _secureStorageRepository;
          }),
        ],
        child: App(),
      ),
    ),
  );
}
