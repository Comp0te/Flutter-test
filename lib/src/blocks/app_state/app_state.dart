import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';
import 'package:flutter_app/src/utils/state_helper.dart';

@immutable
class AppState extends EquatableClass {
  final Map<String, User> users;

  AppState({
    @required this.users,
  }) : super([users]);

  factory AppState.init() => AppState(
        users: {},
      );

  AppState update({
    List<User> users,
  }) {
    return AppState(
      users: StateHelper.updateEntities<User>(
        stateEntities: this.users,
        eventEntitiesList: users,
      ),
    );
  }

  AppState delete({
    List<String> usersIds,
  }) {
    return AppState(
      users: StateHelper.deleteEntities<User>(
        stateEntities: this.users,
        entitiesIds: usersIds,
      ),
    );
  }
}
