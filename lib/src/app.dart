import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/routes/main.dart';
import 'package:flutter_app/src/routes/auth.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<AuthBloc>(context),
      builder: (BuildContext context, AuthState state) {
        return state.isAuthenticated ? _main(context) : _auth(context);
      },
    );
  }

  Widget _main(BuildContext context) {
    final FirebaseMessagingRepository _firebaseMessagingRepository =
        RepositoryProvider.of<FirebaseMessagingRepository>(context);

    final AppStateBloc _appStateBloc = AppStateBloc();
    final ActiveIndexBloc _drawerActiveIndexBloc = ActiveIndexBloc();
    final FirebaseMessagingBloc _firebaseMessagingBloc = FirebaseMessagingBloc(
      firebaseMessagingRepository: _firebaseMessagingRepository,
    );

    final GlobalKey<NavigatorState> mainNavigatorKey =
        GlobalKey<NavigatorState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppStateBloc>(
          builder: (context) {
            return _appStateBloc;
          },
        ),
        BlocProvider<FirebaseMessagingBloc>(
          builder: (context) {
            return _firebaseMessagingBloc
              ..dispatch(
                RequestNotificationPermissions(),
              )
              ..dispatch(
                ConfigureFirebaseMessaging(
                  navigatorKey: mainNavigatorKey,
                ),
              );
          },
        ),
        BlocProvider<ActiveIndexBloc>(
          builder: (context) {
            return _drawerActiveIndexBloc;
          },
        ),
      ],
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        initialRoute: MainRouteNames.home,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MainRouteNames.home:
              return MainRoutes.homeScreenRoute(context);
              break;

            case MainRouteNames.database:
              return MainRoutes.databaseScreenRoute(context);
              break;

            case MainRouteNames.camera:
              return MainRoutes.cameraScreenRoute(context);
              break;

            default:
              return null;
          }
        },
      ),
    );
  }

  Widget _auth(BuildContext context) {
    return MaterialApp(
      initialRoute: AuthRouteNames.login,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AuthRouteNames.login:
            return AuthRoutes.loginRoute(context);
            break;

          case AuthRouteNames.register:
            return AuthRoutes.registerRoute(context);
            break;

          default:
            return null;
        }
      },
    );
  }
}
