import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class PostersFetchBloc extends Bloc<PostersFetchEvent, PostersFetchState> {
  final PostersRepository _postersRepository;

  PostersFetchBloc({
    @required PostersRepository postersRepository,
  })  : assert(postersRepository != null),
        _postersRepository = postersRepository;

  @override
  PostersFetchState get initialState => PostersFetchState.init();

  @override
  Stream<PostersFetchState> mapEventToState(PostersFetchEvent event) async* {
    if (event is PostersFetchFirstPageRequest) {
      yield* _mapPostersFetchFirstRequestToState(event);
    } else if (event is PostersFetchNextPageRequest) {
      yield* _mapPostersFetchNextRequestToState(event);
    } else if (event is PostersFetchRequestSuccess) {
      yield* _mapPostersFetchRequestSuccessToState(event);
    } else if (event is PostersFetchRequestFailure) {
      yield* _mapPostersFetchRequestFailureToState(event);
    }
  }

  Stream<PostersFetchState> _mapPostersFetchFirstRequestToState(
      PostersFetchFirstPageRequest event) async* {
    yield PostersFetchState.init(isLoadingFirstPage: true);

    try {
      final postersFetchResponse = await _postersRepository.fetchPosters();

      add(PostersFetchRequestSuccess(response: postersFetchResponse));
    } on Exception catch (err) {
      add(PostersFetchRequestFailure(error: err));
    }
  }

  Stream<PostersFetchState> _mapPostersFetchNextRequestToState(
      PostersFetchNextPageRequest event) async* {
    if (!state.isLoadingNextPage) {
      yield state.copyWith(isLoadingNextPage: true);

      try {
        final postersFetchResponse =
            await _postersRepository.fetchPosters(page: event.page);

        add(PostersFetchRequestSuccess(
          response: postersFetchResponse,
          isSuccessFirstRequest: false,
        ));
      } on Exception catch (err) {
        add(PostersFetchRequestFailure(
          error: err,
          isErrorFirstRequest: false,
        ));
      }
    }
  }

  Stream<PostersFetchState> _mapPostersFetchRequestSuccessToState(
    PostersFetchRequestSuccess event,
  ) async* {
    yield state.copyWith(
      isLoadingFirstPage: event.isSuccessFirstRequest ? false : null,
      isLoadingNextPage: event.isSuccessFirstRequest ? null : false,
      data: event.response,
    );
  }

  Stream<PostersFetchState> _mapPostersFetchRequestFailureToState(
    PostersFetchRequestFailure event,
  ) async* {
    yield state.copyWith(
      isLoadingFirstPage: event.isErrorFirstRequest ? false : null,
      isLoadingNextPage: event.isErrorFirstRequest ? null : false,
      error: event.error,
    );
  }
}
