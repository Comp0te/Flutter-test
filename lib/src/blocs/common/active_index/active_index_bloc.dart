import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class ActiveIndexBloc extends Bloc<ActiveIndexEvent, ActiveIndexState> {
  final int initialIndex;

  ActiveIndexBloc({this.initialIndex});

  @override
  ActiveIndexState get initialState => ActiveIndexState.init(initialIndex);

  @override
  Stream<ActiveIndexState> mapEventToState(ActiveIndexEvent event) async* {
    if (event is SetActiveIndex) {
      yield state.copyWith(
        activeIndex: event.index,
      );
    }
  }
}
