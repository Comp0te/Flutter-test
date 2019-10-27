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
    final _posterFetchBloc = BlocProvider.of<PostersFetchBloc>(context);
    final _appStateBloc = BlocProvider.of<AppStateBloc>(context);

    return BlocListener<PostersFetchBloc, PostersFetchState>(
      bloc: _posterFetchBloc,
      condition: (prev, cur) {
        return (prev.isLoadingFirstPage && !cur.isLoadingFirstPage) ||
            (prev.isLoadingNextPage && !cur.isLoadingNextPage);
      },
      listener: (context, state) {
        if (state.isSuccess) {
          _appStateBloc.add(AppStateSavePostersResponse(
            postersResponse: state.data,
          ));
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
