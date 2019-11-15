import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState> {
  final DatabaseRepository _databaseRepository;
  final ImageDatabaseRepository _imageDatabaseRepository;

  AppStateBloc({
    @required DatabaseRepository databaseRepository,
    @required ImageStoreRepository imageDatabaseRepository,
  })  : assert(databaseRepository != null),
        assert(imageDatabaseRepository != null),
        _databaseRepository = databaseRepository,
        _imageDatabaseRepository = imageDatabaseRepository;

  @override
  AppState get initialState => AppState.init();

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async* {
    if (event is AppStateUpdateUsers) {
      yield state.copyWith(
        users: event.users,
      );
    } else if (event is AppStateDeleteUsers) {
      yield state.delete(
        usersIds: event.usersIds,
      );
    } else if (event is AppStateUpdatePosters) {
      yield state.copyWith(
        posters: event.posters,
      );
    } else if (event is AppStateDeletePosters) {
      yield state.delete(
        postersIds: event.postersIds,
      );
    } else if (event is AppStateSavePostersResponse) {
      yield* _mapPostersResponseToState(event);
    }
  }

  Stream<AppState> _mapPostersResponseToState(
    AppStateSavePostersResponse event,
  ) async* {
    final users = event.postersResponse.data
        .map((posterResponse) => posterResponse.owner)
        .toList();

    final posters = event.postersResponse.data
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

    await _databaseRepository.insertUsers(users);
    await _databaseRepository.insertPosters(posters);
    await _databaseRepository.insertPosterImages(posters);

    Stream.fromIterable(posters).listen((poster) {
      if (poster.images != null && poster.images.isNotEmpty) {
        Stream.fromIterable(poster.images)
            .forEach((image) => _imageDatabaseRepository.saveImage(image.file));
      }
    });

    yield state.copyWith(posters: posters, users: users);
  }
}
