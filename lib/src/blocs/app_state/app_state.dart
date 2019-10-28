import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class AppState extends EquatableClass with StateUpdaterMixin {
  final Map<String, User> users;
  final Map<String, PosterNormalized> posters;

  AppState({
    @required this.users,
    @required this.posters,
  });

  factory AppState.init() => AppState(
        users: {},
        posters: {},
      );

  AppState copyWith({
    List<User> users,
    List<PosterNormalized> posters,
  }) {
    return AppState(
      users: updateEntities<User>(
        stateEntities: this.users,
        eventEntitiesList: users,
      ),
      posters: updateEntities<PosterNormalized>(
        stateEntities: this.posters,
        eventEntitiesList: posters,
      ),
    );
  }

  AppState delete({
    List<String> usersIds,
    List<String> postersIds,
  }) {
    return AppState(
      users: deleteEntities<User>(
        stateEntities: users,
        entitiesIds: usersIds,
      ),
      posters: deleteEntities<PosterNormalized>(
        stateEntities: posters,
        entitiesIds: postersIds,
      ),
    );
  }

  @override
  String toString() {
    return '======= AppState users = $users\n,'
        '======= AppState posters = $posters\n'
        '';
  }

  @override
  List<Object> get props => [users, posters];
}
