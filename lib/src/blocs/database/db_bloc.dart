import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class DBBloc extends Bloc<DBEvent, DBState> {
  final DatabaseRepository databaseRepository;
  final AppStateBloc appStateBloc;

  DBBloc({
    @required this.databaseRepository,
    @required this.appStateBloc,
  })  : assert(databaseRepository != null),
        assert(appStateBloc != null);

  @override
  DBState get initialState => DBInitial();

  @override
  Stream<DBState> mapEventToState(DBEvent event) async* {
    if (event is DBInsertUsers) {
      yield DBLoading();
      await databaseRepository.insertUsers(event.users);
      yield DBLoaded();
    } else if (event is DBInsertPosters) {
      yield DBLoading();
      await databaseRepository.insertPosters(event.posters);
      yield DBLoaded();
    } else if (event is DBInsertPosterImages) {
      yield DBLoading();
      await databaseRepository.insertPosterImages(event.posters);
      yield DBLoaded();
    } else if (event is DBGetNormalizedPosters) {
      yield DBLoading();

      final posters = await databaseRepository.getNormalizedPosters();
      appStateBloc.add(AppStateUpdatePosters(posters: posters));

      yield DBLoaded();
    }
  }
}
