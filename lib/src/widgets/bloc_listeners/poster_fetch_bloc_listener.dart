import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class PosterFetchBlocListener extends StatelessWidget with SnackBarMixin {
  final Widget child;

  const PosterFetchBlocListener({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostersFetchBloc, PostersFetchState>(
      listener: (context, state) {
        if (state is PostersFetchSuccessful) {
          BlocProvider.of<AppStateBloc>(context).add(
            AppStateSavePostersResponse(postersResponse: state.data),
          );
        }

        if (state is PostersFetchFailed) {
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
