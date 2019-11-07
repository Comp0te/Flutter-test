import 'package:flutter/material.dart';

import 'package:flutter_app/src/widgets/bloc_listeners/auth_bloc_listener.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class AuthMultiLoginBlocListener extends StatelessWidget {
  final Widget child;

  const AuthMultiLoginBlocListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthBlocListener<LoginBloc, LoginState>(
      child: AuthBlocListener<GoogleLoginBloc, GoogleLoginState>(
        child: child,
      ),
    );
  }
}
