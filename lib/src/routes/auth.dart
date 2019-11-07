import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/screens/screens.dart';

abstract class AuthRoutes {
  static AuthRepository _authRepository(BuildContext context) =>
      RepositoryProvider.of<AuthRepository>(context);

  static Route<AnimatedLoginScreen> loginRoute(BuildContext context) {
    return PageTransition(
      type: PageTransitionType.size,
      alignment: Alignment.center,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            builder: (context) => LoginBloc(
              authRepository: _authRepository(context),
            ),
          ),
          BlocProvider<GoogleLoginBloc>(
            builder: (context) => GoogleLoginBloc(
              authRepository: _authRepository(context),
            ),
          ),
        ],
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
            authRepository: _authRepository(context),
          );
        },
        child: RegisterScreen(),
      ),
    );
  }
}
