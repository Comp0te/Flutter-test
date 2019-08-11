import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  @override
  AppState get initialState => AppState.init();

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    if (event is AppStateUpdateUsers) {
      yield currentState.copyWith(
        users: event.users,
      );
    } else if (event is AppStateDeleteUsers) {
      yield currentState.delete(
        usersIds: event.usersIds,
      );
    } else if (event is AppStateUpdatePosters) {
      yield currentState.copyWith(
        posters: event.posters,
      );
    } else if (event is AppStateDeletePosters) {
      yield currentState.delete(
        postersIds: event.postersIds,
      );
    }
  }
}
