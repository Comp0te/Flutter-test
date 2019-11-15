import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class AppBlocListener extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> mainNavigatorKey;

  const AppBlocListener({
    Key key,
    @required this.child,
    @required this.mainNavigatorKey,
  })  : assert(child != null),
        assert(mainNavigatorKey != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      condition: (prev, cur) => prev.runtimeType != cur.runtimeType,
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          BlocProvider.of<FirebaseMessagingBloc>(context)
            ..add(RequestNotificationPermissions())
            ..add(ConfigureFirebaseMessaging(navigatorKey: mainNavigatorKey));
        }
      },
      child: child,
    );
  }
}
