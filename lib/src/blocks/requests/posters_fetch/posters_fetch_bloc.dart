import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/models/model.dart';

class PostersFetchBloc extends Bloc<PostersFetchEvent, PostersFetchState> {
  final PostersRepository _postersRepository;
  final DBRepository _dbRepository;
  final AppStateBloc _appStateBloc;
  final ImageStoreRepository _imageStoreRepository;

  PostersFetchBloc({
    @required AppStateBloc appStateBloc,
    @required PostersRepository postersRepository,
    @required DBRepository dbRepository,
    @required ImageStoreRepository imageStoreRepository,
  })  : assert(appStateBloc != null),
        assert(postersRepository != null),
        assert(dbRepository != null),
        assert(imageStoreRepository != null),
        _appStateBloc = appStateBloc,
        _postersRepository = postersRepository,
        _dbRepository = dbRepository,
        _imageStoreRepository = imageStoreRepository;

  PostersFetchState get initialState => PostersFetchState.init();

  @override
  Stream<PostersFetchState> mapEventToState(PostersFetchEvent event) async* {
    if (event is PostersFetchRequestInit) {
      yield PostersFetchState.init();
    } else if (event is PostersFetchFirstPageRequest) {
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
    yield currentState.update(
      isLoadingFirstPage: true,
    );

    try {
      var postersFetchResponse = await _postersRepository.fetchPosters();

      dispatch(
        PostersFetchRequestSuccess(postersFetchResponse: postersFetchResponse),
      );
    } on Exception catch (err) {
      dispatch(PostersFetchRequestFailure(error: err));
    }
  }

  Stream<PostersFetchState> _mapPostersFetchNextRequestToState(
      PostersFetchNextPageRequest event) async* {
    if (!currentState.isLoadingNextPage) {
      yield currentState.update(
        isLoadingNextPage: true,
      );

      try {
        var postersFetchResponse =
            await _postersRepository.fetchPosters(page: event.page);

        dispatch(
          PostersFetchRequestSuccess(
            postersFetchResponse: postersFetchResponse,
            isSuccessFirstRequest: false,
          ),
        );
      } on Exception catch (err) {
        dispatch(PostersFetchRequestFailure(
          error: err,
          isErrorFirstRequest: false,
        ));
      }
    }
  }

  Stream<PostersFetchState> _mapPostersFetchRequestSuccessToState(
    PostersFetchRequestSuccess event,
  ) async* {
    List<User> users = event.postersFetchResponse.data
        .map((posterResponse) => posterResponse.owner)
        .toList();

    List<PosterNormalized> posters = event.postersFetchResponse.data
        .map((posterResponse) => PosterNormalized(
              id: posterResponse.id,
              ownerId: posterResponse.owner.id,
              theme: posterResponse.theme,
              text: posterResponse.text ?? '',
              price: posterResponse.price,
              currency: posterResponse.currency,
              images: posterResponse.images,
              contractPrice: posterResponse.contractPrice,
              location: posterResponse.location,
              category: posterResponse.category,
              activatedAt: posterResponse.activatedAt,
              isActive: posterResponse.isActive,
            ))
        .toList();

    _appStateBloc.dispatch(
      AppStateUpdateUsers(users: users),
    );

    _appStateBloc.dispatch(
      AppStateUpdatePosters(posters: posters),
    );

    await _dbRepository.insertUsers(users);
    await _dbRepository.insertPosters(posters);
    await _dbRepository.insertPosterImages(posters);

    Stream.fromIterable(posters).listen((poster) async {
      if (poster.images != null && poster.images.isNotEmpty) {
        await _imageStoreRepository.saveImage(poster.images[0].file);
      }
    });

    yield currentState.update(
      isLoadingFirstPage: event.isSuccessFirstRequest ? false : null,
      isLoadingNextPage: event.isSuccessFirstRequest ? null : false,
      data: event.postersFetchResponse,
    );
  }

  Stream<PostersFetchState> _mapPostersFetchRequestFailureToState(
    PostersFetchRequestFailure event,
  ) async* {
    yield currentState.update(
      isLoadingFirstPage: event.isErrorFirstRequest ? false : null,
      isLoadingNextPage: event.isErrorFirstRequest ? null : false,
      error: event.error,
    );
  }
}
