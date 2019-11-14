import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class DBBloc extends Bloc<DBEvent, DBState> {
  final DBRepository dbRepository;
  final AppStateBloc appStateBloc;

  DBBloc({
    @required this.dbRepository,
    @required this.appStateBloc,
  })  : assert(dbRepository != null),
        assert(appStateBloc != null);

  @override
  DBState get initialState => DBInitial();

  @override
  Stream<DBState> mapEventToState(DBEvent event) async* {
    if (event is DBInsertUsers) {
      yield DBLoading();
      await dbRepository.insertUsers(event.users);
      yield DBLoaded();
    } else if (event is DBInsertPosters) {
      yield DBLoading();
      await dbRepository.insertPosters(event.posters);
      yield DBLoaded();
    } else if (event is DBInsertPosterImages) {
      yield DBLoading();
      await dbRepository.insertPosterImages(event.posters);
      yield DBLoaded();
    } else if (event is DBGetNormalizedPosters) {
      yield DBLoading();

      final posters = await dbRepository.getNormalizedPosters();
      appStateBloc.add(AppStateUpdatePosters(posters: posters));

      yield DBLoaded();
    }
  }
}
