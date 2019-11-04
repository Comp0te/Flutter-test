import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/routes/routes.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/constants/constants.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context)..add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocListener(
      mainNavigatorKey: mainNavigatorKey,
      child: BlocBuilder<AuthBloc, AuthState>(
        condition: (prev, cur) => prev.isAuthenticated != cur.isAuthenticated,
        builder: (context, state) {
          return state.isAuthenticated ? _main(context) : _auth(context);
        },
      ),
    );
  }

  Widget _main(BuildContext context) {
    return MaterialApp(
      navigatorKey: mainNavigatorKey,
      initialRoute: MainRouteNames.home,
      onGenerateRoute: (RouteSettings settings) {
        BlocProvider.of<MainDrawerBloc>(context).add(SetMainDrawerRoute(
          routeName: settings.name,
        ));

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

          case MainRouteNames.googleMap:
            return MainRoutes.googleMapRoute(context);
            break;

          default:
            return null;
        }
      },
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
