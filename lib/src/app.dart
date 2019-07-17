import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/screens/login_screen.dart';
import 'package:flutter_app/src/screens/home_screen.dart';

import 'package:flutter_app/src/repositories/repositories.dart';

import 'blocks/blocks.dart';

class App extends StatelessWidget {
  final SecureStorageRepository _secureStorageRepository;
  final AuthRepository _authRepository;

  App({
    Key key,
    @required SecureStorageRepository secureStorageRepository,
    @required AuthRepository authRepository,
  })  : assert(secureStorageRepository != null),
        _secureStorageRepository = secureStorageRepository,
        _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder(
        bloc: BlocProvider.of<AuthBloc>(context),
        builder: (BuildContext context, AuthState state) {
          if (state.isAuthenticated) {

            return HomeScreen();
          } else {

            return BlocProvider(
              builder: (context) => LoginBloc(
                    secureStorageRepository: _secureStorageRepository,
                    authRepository: _authRepository,
                  ),
              child: LoginScreen(),
            );
          }
        },
      ),
    );
  }
}
