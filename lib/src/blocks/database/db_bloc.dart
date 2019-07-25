import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class DBBloc extends Bloc<DBEvent, DBState> {
  final DBRepository dbRepository;
  final AppStateBloc appStateBloc;

  DBBloc({
    @required this.dbRepository,
    @required this.appStateBloc,
  })  : assert(dbRepository != null),
        assert(appStateBloc != null);

  DBState get initialState => DBState.init();

  @override
  Stream<DBState> mapEventToState(DBEvent event) async* {
    if (event is DBInsertUsers) {
      yield DBState.loading();
      await dbRepository.insertUsers(event.users);
      yield DBState.loaded();
    } else if (event is DBInsertPosters) {
      yield DBState.loading();
      await dbRepository.insertPosters(event.posters);
      yield DBState.loaded();
    } else if (event is DBInsertPosterImages) {
      yield DBState.loading();
      await dbRepository.insertPosterImages(event.posters);
      yield DBState.loaded();
    } else if (event is DBGetNormalizedPosters) {
      yield DBState.loading();

      List<PosterNormalized> posters = await dbRepository.getNormalizedPosters();
      appStateBloc.dispatch(AppStateUpdatePosters(posters: posters));

      yield DBState.loaded();
    }
  }
}
