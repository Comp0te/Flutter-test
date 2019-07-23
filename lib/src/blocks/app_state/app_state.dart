import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';
import 'package:flutter_app/src/utils/state_helper.dart';

@immutable
class AppState extends EquatableClass {
  final Map<String, User> users;
  final Map<String, PosterNormalized> posters;

  AppState({
    @required this.users,
    @required this.posters,
  }) : super([users, posters]);

  factory AppState.init() => AppState(
        users: {},
        posters: {},
      );

  AppState update({
    List<User> users,
    List<PosterNormalized> posters,
  }) {
    return AppState(
      users: StateHelper.updateEntities<User>(
        stateEntities: this.users,
        eventEntitiesList: users,
      ),
      posters: StateHelper.updateEntities<PosterNormalized>(
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
      users: StateHelper.deleteEntities<User>(
        stateEntities: this.users,
        entitiesIds: usersIds,
      ),
      posters: StateHelper.deleteEntities<PosterNormalized>(
        stateEntities: this.posters,
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
}
