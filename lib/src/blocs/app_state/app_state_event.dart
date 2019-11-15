import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

class AppStateInit extends AppStateEvent {}

class AppStateUpdateUsers extends AppStateEvent {
  final List<User> users;

  const AppStateUpdateUsers({this.users});

  @override
  List<Object> get props => [users];
}

class AppStateDeleteUsers extends AppStateEvent {
  final List<String> usersIds;

  const AppStateDeleteUsers({this.usersIds});

  @override
  List<Object> get props => [usersIds];
}

class AppStateUpdatePosters extends AppStateEvent {
  final List<PosterNormalized> posters;

  const AppStateUpdatePosters({this.posters});

  @override
  List<Object> get props => [posters];
}

class AppStateDeletePosters extends AppStateEvent {
  final List<String> postersIds;

  const AppStateDeletePosters({this.postersIds});

  @override
  List<Object> get props => [postersIds];
}

class AppStateSavePostersResponse extends AppStateEvent {
  final PostersFetchResponse postersResponse;

  const AppStateSavePostersResponse({this.postersResponse});

  @override
  List<Object> get props => [postersResponse];
}
