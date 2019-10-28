import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

abstract class AuthRoutes {
  static SecureStorageRepository _secureStorageRepository(
          BuildContext context) =>
      RepositoryProvider.of<SecureStorageRepository>(context);

  static AuthRepository _authRepository(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  static Route<AnimatedLoginScreen> loginRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.size,
      alignment: Alignment.center,
      child: BlocProvider(
        builder: (context) {
          return LoginBloc(
            secureStorageRepository: _secureStorageRepository(context),
            authRepository: _authRepository(context),
          );
        },
        child: AnimatedLoginScreen(),
      ),
    );
  }

  static Route<RegisterScreen> registerRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.size,
      alignment: Alignment.center,
      child: BlocProvider(
        builder: (context) {
          return RegisterBloc(
            secureStorageRepository: _secureStorageRepository(context),
            authRepository: _authRepository(context),
          );
        },
        child: RegisterScreen(),
      ),
    );
  }
}
