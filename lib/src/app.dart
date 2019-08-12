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
    final _firebaseMessagingRepository =
        RepositoryProvider.of<FirebaseMessagingRepository>(context);

    final _appStateBloc = AppStateBloc();
    final _drawerActiveIndexBloc = ActiveIndexBloc();
    final _firebaseMessagingBloc = FirebaseMessagingBloc(
      firebaseMessagingRepository: _firebaseMessagingRepository,
    );

    final mainNavigatorKey = GlobalKey<NavigatorState>();

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
              _drawerActiveIndexBloc.dispatch(SetActiveIndex(index: 0));
              return MainRoutes.homeScreenRoute(context);
              break;

            case MainRouteNames.database:
              _drawerActiveIndexBloc.dispatch(SetActiveIndex(index: 1));
              return MainRoutes.databaseScreenRoute(context);
              break;

            case MainRouteNames.camera:
              _drawerActiveIndexBloc.dispatch(SetActiveIndex(index: 2));
              return MainRoutes.cameraScreenRoute(context);
              break;

            case MainRouteNames.googleMap:
              _drawerActiveIndexBloc.dispatch(SetActiveIndex(index: 3));
              return MainRoutes.googleMapRoute(context);
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
