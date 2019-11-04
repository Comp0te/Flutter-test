import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationState.init();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is SetMainDrawerRoute) {
      final activeIndex = state.drawerItemOptions.indexWhere(
        (item) => item.routeName == event.routeName,
      );

      yield state.copyWith(
        activeDrawerIndex:
            activeIndex >= 0 ? activeIndex : state.activeDrawerIndex,
      );
    }
  }
}
