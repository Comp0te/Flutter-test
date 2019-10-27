import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class AuthBlocListener<B extends Bloc<dynamic, S>, S extends RequestState>
    extends StatelessWidget with SnackBarMixin {
  final Widget child;

  const AuthBlocListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<B>(context);

    return BlocListener<B, S>(
      bloc: _bloc,
      condition: (prev, cur) {
        return prev.isLoading && !cur.isLoading;
      },
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }

        if (state.isFailure) {
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
