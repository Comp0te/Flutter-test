import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class DBEvent extends Equatable {
  const DBEvent();
}

class DBInit extends DBEvent {
  @override
  List<Object> get props => [];
}

class DBInsertUsers extends DBEvent {
  final List<User> users;

  DBInsertUsers({this.users});

  @override
  List<Object> get props => [users];
}

class DBInsertPosters extends DBEvent {
  final List<PosterNormalized> posters;

  DBInsertPosters({this.posters});

  @override
  List<Object> get props => [posters];
}

class DBInsertPosterImages extends DBEvent {
  final List<PosterNormalized> posters;

  DBInsertPosterImages({this.posters});

  @override
  List<Object> get props => [posters];
}

class DBGetNormalizedPosters extends DBEvent {
  @override
  List<Object> get props => [];
}