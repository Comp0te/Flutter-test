import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  @override
  DrawerState get initialState => DrawerState.init();

  @override
  Stream<DrawerState> mapEventToState(
    DrawerEvent event,
  ) async* {
    if (event is SetDrawerActiveIndex) {
      yield currentState.update(
        activeIndex: event.activeIndex,
      );
    }
  }
}
