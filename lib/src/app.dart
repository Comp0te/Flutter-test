import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

import 'package:flutter_app/src/screens/screens.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SecureStorageRepository _secureStorageRepository =
        RepositoryProvider.of<SecureStorageRepository>(context);
    final AuthRepository _authRepository =
        RepositoryProvider.of<AuthRepository>(context);
    final PostersRepository _postersRepository =
        RepositoryProvider.of<PostersRepository>(context);

    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, AuthState state) {
        return state.isAuthenticated
            ? BlocProvider(
                builder: (context) {
                  return AppStateBloc();
                },
                child: MaterialApp(
                  key: GlobalKey(),
                  initialRoute: MainRouteNames.home,
                  routes: {
                    MainRouteNames.home: (context) {
                      return BlocProvider(
                        builder: (context) {
                          return PostersFetchBloc(
                            postersRepository: _postersRepository,
                            appStateBloc:
                                BlocProvider.of<AppStateBloc>(context),
                          )..dispatch(PostersFetchRequest());
                        },
                        child: HomeScreen(),
                      );
                    },
                  },
                ),
              )
            : MaterialApp(
                key: GlobalKey(),
                initialRoute: AuthRouteNames.login,
                routes: {
                  AuthRouteNames.login: (context) {
                    return BlocProvider(
                      builder: (context) {
                        return LoginBloc(
                          secureStorageRepository: _secureStorageRepository,
                          authRepository: _authRepository,
                        );
                      },
                      child: AnimatedLoginScreen(),
                    );
                  },
                  AuthRouteNames.register: (context) {
                    return BlocProvider(
                      builder: (context) {
                        return RegisterBloc(
                          secureStorageRepository: _secureStorageRepository,
                          authRepository: _authRepository,
                        );
                      },
                      child: RegisterScreen(),
                    );
                  },
                },
              );
      },
    );
  }
}
