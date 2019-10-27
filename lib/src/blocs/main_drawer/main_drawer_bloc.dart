import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class MainDrawerBloc extends Bloc<MainDrawerEvent, MainDrawerState> {
  @override
  MainDrawerState get initialState => MainDrawerState.init();

  @override
  Stream<MainDrawerState> mapEventToState(MainDrawerEvent event) async* {
    if (event is SetMainDrawerRoute) {
      final activeIndex = state.drawerItemOptions
          .indexWhere((item) => item.routeName == event.routeName);

      yield state.copyWith(
          activeDrawerIndex:
              activeIndex >= 0 ? activeIndex : state.activeDrawerIndex);
    }
  }
}
