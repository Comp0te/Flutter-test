import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/routes/main.dart';
import 'package:flutter_app/src/routes/auth.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final mainNavigatorKey = GlobalKey<NavigatorState>();
  AppStateBloc _appStateBloc;
  ActiveIndexBloc _drawerActiveIndexBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: BlocProvider.of(context),
      condition: (prev, cur) => prev.isAuthenticated != cur.isAuthenticated,
      builder: (context, state) {
        if (state.isAuthenticated) {
          _appStateBloc = AppStateBloc();
          _drawerActiveIndexBloc = ActiveIndexBloc();
        }

        return state.isAuthenticated ? _main(context) : _auth(context);
      },
    );
  }

  Widget _main(BuildContext context) {
    final _firebaseMessagingRepository =
        RepositoryProvider.of<FirebaseMessagingRepository>(context);
    final _firebaseMessagingBloc = FirebaseMessagingBloc(
      firebaseMessagingRepository: _firebaseMessagingRepository,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppStateBloc>(
          builder: (context) => _appStateBloc,
        ),
        BlocProvider<FirebaseMessagingBloc>(
          builder: (context) => _firebaseMessagingBloc
            ..add(
              RequestNotificationPermissions(),
            )
            ..add(
              ConfigureFirebaseMessaging(
                navigatorKey: mainNavigatorKey,
              ),
            ),
        ),
        BlocProvider<ActiveIndexBloc>(
          builder: (context) => _drawerActiveIndexBloc,
        ),
      ],
      child: MaterialApp(
        navigatorKey: mainNavigatorKey,
        initialRoute: MainRouteNames.home,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case MainRouteNames.home:
              _drawerActiveIndexBloc.add(SetActiveIndex(index: 0));
              return MainRoutes.homeScreenRoute(context);
              break;

            case MainRouteNames.database:
              _drawerActiveIndexBloc.add(SetActiveIndex(index: 1));
              return MainRoutes.databaseScreenRoute(context);
              break;

            case MainRouteNames.camera:
              _drawerActiveIndexBloc.add(SetActiveIndex(index: 2));
              return MainRoutes.cameraScreenRoute(context);
              break;

            case MainRouteNames.googleMap:
              _drawerActiveIndexBloc.add(SetActiveIndex(index: 3));
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
