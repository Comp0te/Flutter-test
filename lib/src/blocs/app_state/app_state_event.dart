import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class AppStateEvent extends Equatable {
  AppStateEvent([List props = const []]) : super(props);
}

class AppStateInit extends AppStateEvent {}

class AppStateUpdateUsers extends AppStateEvent {
  final List<User> users;

  AppStateUpdateUsers({this.users})
      : super([users]);
}

class AppStateDeleteUsers extends AppStateEvent {
  final List<String> usersIds;

  AppStateDeleteUsers({this.usersIds})
      : super([usersIds]);
}

class AppStateUpdatePosters extends AppStateEvent {
  final List<PosterNormalized> posters;

  AppStateUpdatePosters({this.posters})
      : super([posters]);
}

class AppStateDeletePosters extends AppStateEvent {
  final List<String> postersIds;

  AppStateDeletePosters({this.postersIds})
      : super([postersIds]);
}

