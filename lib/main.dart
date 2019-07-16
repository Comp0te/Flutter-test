import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/data_providers/data_providers.dart';
import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/app.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final AuthRepository authRepository = AuthRepository(
    storage: SecureStorageProvider(
      secureStorage: FlutterSecureStorage(),
    ),
  );
  runApp(
    BlocProvider(
      builder: (context) => AuthBloc(
            authRepository: authRepository,
          )..dispatch(AppStarted()),
      child: App(
        authRepository: authRepository,
      ),
    ),
  );
}
