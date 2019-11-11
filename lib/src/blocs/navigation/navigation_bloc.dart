import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  @override
  NavigationState get initialState => NavigationState.init();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is SetMainDrawerRoute) {
      yield* _mapSetMainDrawerRouteToState(event);
    } else if (event is SetMainDrawerItemOptions) {
      yield* _mapSetMainDrawerItemOptionsToState(event);
    }
  }

  Stream<NavigationState> _mapSetMainDrawerRouteToState(
    SetMainDrawerRoute event,
  ) async* {
    final activeIndex = state.mainDrawerItemOptions.indexWhere(
      (item) => item.routeName == event.routeName,
    );

    yield state.copyWith(
      activeDrawerIndex:
          activeIndex >= 0 ? activeIndex : state.activeDrawerIndex,
    );
  }

  Stream<NavigationState> _mapSetMainDrawerItemOptionsToState(
    SetMainDrawerItemOptions event,
  ) async* {
    yield state.copyWith(mainDrawerItemOptions: event.options);
  }
}
