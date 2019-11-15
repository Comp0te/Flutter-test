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
  PostersFetchState get initialState => PostersFetchInitial();

  @override
  Stream<PostersFetchState> mapEventToState(PostersFetchEvent event) async* {
    if (event is PostersFetchFirstPageRequest) {
      yield* _mapPostersFetchFirstRequestToState(event);
    } else if (event is PostersFetchNextPageRequest) {
      yield* _mapPostersFetchNextRequestToState(event);
    }
  }

  Stream<PostersFetchState> _mapPostersFetchFirstRequestToState(
      PostersFetchFirstPageRequest event) async* {
    yield PostersFetchFirstRequestLoading();

    try {
      final postersFetchResponse = await _postersRepository.fetchPosters();

      yield PostersFetchSuccessful(data: postersFetchResponse);
    } on Exception catch (error) {
      yield PostersFetchFailed(error: error);
    }
  }

  Stream<PostersFetchState> _mapPostersFetchNextRequestToState(
      PostersFetchNextPageRequest event) async* {
    if (state is! PostersFetchNextRequestLoading) {
      yield PostersFetchNextRequestLoading();

      try {
        final postersFetchResponse =
            await _postersRepository.fetchPosters(page: event.page);

        yield PostersFetchSuccessful(data: postersFetchResponse);
      } on Exception catch (error) {
        yield PostersFetchFailed(error: error);
      }
    }
  }
}
