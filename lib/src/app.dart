import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

import 'package:flutter_app/src/screens/screens.dart';

import 'models/model.dart';

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
    final ImageStoreRepository _imageStoreRepository =
        RepositoryProvider.of<ImageStoreRepository>(context);
    final CameraRepository _cameraRepository =
        RepositoryProvider.of<CameraRepository>(context);

    final AppStateBloc _appStateBloc = AppStateBloc();
    final ActiveIndexBloc _drawerActiveIndexBloc = ActiveIndexBloc();
    final CameraBloc _cameraBloc = CameraBloc(
      cameraRepository: _cameraRepository,
    );

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
                          type: PageTransitionType.fade,
                          alignment: Alignment.center,
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider<PostersFetchBloc>(
                                builder: (context) {
                                  return PostersFetchBloc(
                                    postersRepository: _postersRepository,
                                    appStateBloc: _appStateBloc,
                                    dbRepository: _dbRepository,
                                    imageStoreRepository: _imageStoreRepository,
                                  );
                                },
                              ),
                              BlocProvider<ActiveIndexBloc>(
                                builder: (context) {
                                  return _drawerActiveIndexBloc;
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
                              ),
                              BlocProvider<ActiveIndexBloc>(
                                builder: (context) {
                                  return _drawerActiveIndexBloc;
                                },
                              )
                            ],
                            child: DatabaseScreen(),
                          ),
                        );
                        break;

                      case MainRouteNames.camera:
                        return PageTransition(
                          type: PageTransitionType.fade,
                          alignment: Alignment.center,
                          child: MultiBlocProvider(
                            providers: [
                              BlocProvider<CameraBloc>(
                                builder: (context) {
                                  return _cameraBloc..dispatch(InitCamera());
                                },
                              ),
                              BlocProvider<ActiveIndexBloc>(
                                builder: (context) {
                                  return _drawerActiveIndexBloc;
                                },
                              ),
                            ],
                            child: CameraScreen(),
                          ),
                        );
                        break;

                      case MainRouteNames.cameraPreview:
                        final args = settings.arguments;

                        return PageTransition(
                          type: PageTransitionType.leftToRight,
                          alignment: Alignment.centerLeft,
                          child: BlocProvider<CameraBloc>.value(
                            value: _cameraBloc,
                            child: CameraPreviewScreen(
                              screenArgs:
                                  args is CameraPreviewScreenArgs ? args : null,
                            ),
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
