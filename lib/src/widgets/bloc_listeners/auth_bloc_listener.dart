import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class AuthBlocListener<B extends Bloc<RequestEvent, S>, S extends RequestState>
    extends StatelessWidget with SnackBarMixin {
  final Widget child;

  const AuthBlocListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<B, S>(
      condition: (prev, cur) {
        return prev is RequestLoading;
      },
      listener: (context, state) {
        if (state is RequestSuccessful<AuthResponse>) {
          _authBloc.add(LoggedIn(authResponse: state.data));
        }

        if (state is RequestFailed) {
          showSnackBarError(
            context: context,
            error: state.error,
          );
        }
      },
      child: child,
    );
  }
}
