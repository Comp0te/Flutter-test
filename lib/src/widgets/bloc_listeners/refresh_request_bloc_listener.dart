import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

class RefreshRequestBlocListener<B extends Bloc<dynamic, S>,
    S extends RequestState> extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;

  const RefreshRequestBlocListener({
    Key key,
    @required this.child,
    @required this.onRefresh,
  })  : assert(child != null),
        assert(onRefresh != null),
        super(key: key);

  @override
  _RefreshRequestBlocListenerState createState() =>
      _RefreshRequestBlocListenerState<B, S>();
}

class _RefreshRequestBlocListenerState<B extends Bloc<dynamic, S>,
    S extends RequestState> extends State<RefreshRequestBlocListener> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
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
