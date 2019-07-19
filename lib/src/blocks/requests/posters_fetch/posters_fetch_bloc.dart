import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class PostersFetchBloc extends Bloc<PostersFetchEvent, PostersFetchState> {
  final PostersRepository postersRepository;

  PostersFetchBloc({
    @required this.postersRepository,
  })  : assert(postersRepository != null);

  PostersFetchState get initialState => PostersFetchState.init();

  @override
  Stream<PostersFetchState> mapEventToState(PostersFetchEvent event) async* {
    if (event is PostersFetchRequestInit) {
      yield PostersFetchState.init();
    } else if (event is PostersFetchRequest) {
      yield* _mapPostersFetchRequestToState(event);
    } else if (event is PostersFetchRequestSuccess) {
      yield* _mapPostersFetchRequestSuccessToState(event);
    } else if (event is PostersFetchRequestFailure) {
      yield* _mapPostersFetchRequestFailureToState(event);
    }
  }

  Stream<PostersFetchState> _mapPostersFetchRequestToState(PostersFetchRequest event) async* {
    yield currentState.update(
      isLoading: true,
    );

    try {
      var postersFetchResponse = await postersRepository.fetchPosters();

      dispatch(PostersFetchRequestSuccess(postersFetchResponse: postersFetchResponse));
    } on CastError catch (err) {
      print('Cast error ---------------------------- ${err.stackTrace}');
    } catch (err) {
      dispatch(PostersFetchRequestFailure(error: err));
    }
  }

  Stream<PostersFetchState> _mapPostersFetchRequestSuccessToState(
    PostersFetchRequestSuccess event,
  ) async* {
    yield currentState.update(
      isLoading: false,
      data: event.postersFetchResponse,
    );
  }

  Stream<PostersFetchState> _mapPostersFetchRequestFailureToState(
    PostersFetchRequestFailure event,
  ) async* {
    yield currentState.update(
      isLoading: false,
      error: event.error,
    );
  }
}
