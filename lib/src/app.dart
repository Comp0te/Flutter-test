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
  final _authenticatedAppKey = GlobalKey();
  final _unauthenticatedAppKey = GlobalKey();

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
          if (state is AuthAuthenticated) return _authenticatedApp(context);

          return _unauthenticatedApp(context);
        },
      ),
    );
  }

  Widget _authenticatedApp(BuildContext context) {
    return _app(context: context, isAuth: true);
  }

  Widget _unauthenticatedApp(BuildContext context) {
    return _app(context: context, isAuth: false);
  }

  Widget _app({BuildContext context, bool isAuth}) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return MaterialApp(
          // GlobalKey Needed for correct rendering when you change Auth
          key: isAuth // authentication state
              ? _authenticatedAppKey
              : _unauthenticatedAppKey,
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
          initialRoute:
              isAuth ? MainRoutes.initialRoute : AuthRoutes.initialRoute,
          onGenerateRoute: isAuth
              ? MainRoutes.makeOnGenerateRoute(context)
              : AuthRoutes.makeOnGenerateRoute(context),
        );
      },
    );
  }
}
