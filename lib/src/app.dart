import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/routes/routes.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/generated/i18n.dart';

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
    BlocProvider.of<PreferencesBloc>(context)..add(RehydratePreferences());
  }

  @override
  Widget build(BuildContext context) {
    return AppBlocListener(
      mainNavigatorKey: mainNavigatorKey,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) return const Spinner();
          if (state is AuthAuthenticated) return _main(context);

          return _auth(context);
        },
      ),
    );
  }

  Widget _main(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          themeMode: state.themeMode,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              S.delegate.resolution(fallback: defaultLocale),
          theme: lightTheme,
          darkTheme: darkTheme,
          navigatorKey: mainNavigatorKey,
          initialRoute: MainRouteNames.home,
          onGenerateRoute: (RouteSettings settings) {
            BlocProvider.of<NavigationBloc>(context).add(SetMainDrawerRoute(
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
      },
    );
  }

// TODO: find a solution to the problem of the need for MaterialApp duplication
  // in _auth and _main. without this, redirect logic does not work during authentication
  Widget _auth(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          locale: state.locale,
          themeMode: state.themeMode,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback:
              S.delegate.resolution(fallback: defaultLocale),
          theme: lightTheme,
          darkTheme: darkTheme,
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
      },
    );
  }
}
