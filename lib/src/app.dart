import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/src/screens/login_screen.dart';
import 'package:flutter_app/src/screens/splash_screen.dart';
import 'package:flutter_app/src/screens/home_screen.dart';

import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocks/blocks.dart';
import 'data_providers/data_providers.dart';

class App extends StatelessWidget {
  final SecureStorageRepository _secureStorageRepository;

  App({
    Key key,
    @required SecureStorageRepository secureStorageRepository,
  })  : assert(secureStorageRepository != null),
        _secureStorageRepository = secureStorageRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder(
        bloc: BlocProvider.of<AuthBloc>(context),
        builder: (BuildContext context, AuthState state) {
          if (state is AuthUninitialized) {
            return SplashScreen();
          }

          if (state is AuthAuthenticated) {
            return HomeScreen();
          }

          return BlocProvider(
            builder: (context) => LoginBloc(
                  secureStorageRepository: _secureStorageRepository,
                  authRepository: AuthRepository(
                    authApiProvider: AuthApiProvider(dio: Dio()),
                  ),
                ),
            child: LoginScreen(),
          );
        },
      ),
    );
  }
}
