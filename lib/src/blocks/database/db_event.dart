import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class DBEvent extends Equatable {
  DBEvent([List props = const []]) : super(props);
}

class DBInit extends DBEvent {}

class DBInsertUsers extends DBEvent {
  final List<User> users;

  DBInsertUsers({this.users})
      : super([users]);
}

class DBInsertPosters extends DBEvent {
  final List<PosterNormalized> posters;

  DBInsertPosters({this.posters})
      : super([posters]);
}

class DBInsertPosterImages extends DBEvent {
  final List<PosterNormalized> posters;

  DBInsertPosterImages({this.posters})
      : super([posters]);
}

class DBGetNormalizedPosters extends DBEvent {}