import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshRequestBlocListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh; // TODO: add general solution

  const RefreshRequestBlocListener({
    Key key,
    @required this.child,
    @required this.onRefresh,
  })  : assert(child != null),
        assert(onRefresh != null),
        super(key: key);

  @override
  _RefreshRequestBlocListenerState createState() =>
      _RefreshRequestBlocListenerState();
}

class _RefreshRequestBlocListenerState
    extends State<RefreshRequestBlocListener> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostersFetchBloc, PostersFetchState>(
      condition: (prev, cur) {
        return prev.isRefreshing && !cur.isRefreshing;
      },
      listener: (context, state) {
        _refreshCompleter?.complete();
        _refreshCompleter = Completer();
      },
      child: RefreshIndicator(
        onRefresh: () {
          widget.onRefresh();
          return _refreshCompleter.future;
        },
        child: widget.child,
      ),
    );
  }
}
