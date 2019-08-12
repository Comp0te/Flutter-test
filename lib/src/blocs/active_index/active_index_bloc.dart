import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class ActiveIndexBloc extends Bloc<ActiveIndexEvent, ActiveIndexState> {
  @override
  ActiveIndexState get initialState => ActiveIndexState.init();

  @override
  Stream<ActiveIndexState> mapEventToState(ActiveIndexEvent event) async* {
    if (event is SetActiveIndex) {
      yield currentState.copyWith(
        activeIndex: event.index,
      );
    }
  }
}
