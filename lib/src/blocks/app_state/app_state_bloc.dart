import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  AppState get initialState => AppState.init();

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    if (event is AppStateUpdateUsers) {
      yield currentState.update(
        users: event.users,
      );
    } else if (event is AppStateDeleteUsers) {
      yield currentState.delete(
        usersIds: event.usersIds,
      );
    } else if (event is AppStateUpdatePosters) {
      yield currentState.update(
        posters: event.posters,
      );
    } else if (event is AppStateDeletePosters) {
      yield currentState.delete(
        postersIds: event.postersIds,
      );
    }
  }
}
