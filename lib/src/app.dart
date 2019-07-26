import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
    final DBRepository _dbRepository =
        RepositoryProvider.of<DBRepository>(context);

    final AppStateBloc _appStateBloc = AppStateBloc();
    final DrawerBloc _mainDrawerBloc = DrawerBloc();

    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, AuthState state) {
        return state.isAuthenticated
            ? BlocProvider(
                builder: (context) {
                  return _appStateBloc;
                },
                child: MaterialApp(
                  key: GlobalKey(),
                  initialRoute: MainRouteNames.home,
                  onGenerateRoute: (RouteSettings settings) {
                    switch (settings.name) {
                      case MainRouteNames.home:
                        return PageTransition(
                          type: PageTransitionType.rightToLeft,
                          alignment: Alignment.center,
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider<PostersFetchBloc>(
                                builder: (context) {
                                  return PostersFetchBloc(
                                    postersRepository: _postersRepository,
                                    appStateBloc: _appStateBloc,
                                    dbRepository: _dbRepository,
                                  );
                                },
                              ),
                              BlocProvider<DrawerBloc>(
                                builder: (context) {
                                  return _mainDrawerBloc;
                                },
                              )
                            ],
                            child: HomeScreen(),
                          ),
                        );
                        break;

                      case MainRouteNames.database:
                        return PageTransition(
                          type: PageTransitionType.rightToLeft,
                          alignment: Alignment.center,
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider<DBBloc>(
                                builder: (context) {
                                  return DBBloc(
                                    dbRepository: _dbRepository,
                                    appStateBloc: _appStateBloc,
                                  )..dispatch(DBGetNormalizedPosters());
                                },
                                child: DatabaseScreen(),
                              ),
                              BlocProvider<DrawerBloc>(
                                builder: (context) {
                                  return _mainDrawerBloc;
                                },
                              )
                            ],
                            child: DatabaseScreen(),
                          ),
                        );
                        break;

                      default:
                        return null;
                    }
                  },
                ),
              )
            : MaterialApp(
                key: GlobalKey(),
                initialRoute: AuthRouteNames.login,
                onGenerateRoute: (RouteSettings settings) {
                  switch (settings.name) {
                    case AuthRouteNames.login:
                      return PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.center,
                        child: BlocProvider(
                          builder: (context) {
                            return LoginBloc(
                              secureStorageRepository: _secureStorageRepository,
                              authRepository: _authRepository,
                            );
                          },
                          child: AnimatedLoginScreen(),
                        ),
                      );
                      break;

                    case AuthRouteNames.register:
                      return PageTransition(
                        type: PageTransitionType.size,
                        alignment: Alignment.center,
                        child: BlocProvider(
                          builder: (context) {
                            return RegisterBloc(
                              secureStorageRepository: _secureStorageRepository,
                              authRepository: _authRepository,
                            );
                          },
                          child: RegisterScreen(),
                        ),
                      );
                      break;

                    default:
                      return null;
                  }
                },
              );
      },
    );
  }
}
