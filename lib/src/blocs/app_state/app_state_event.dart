import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class AppStateEvent extends Equatable {
  const AppStateEvent();
}

class AppStateInit extends AppStateEvent {
  @override
  List<Object> get props => [];
}

class AppStateUpdateUsers extends AppStateEvent {
  final List<User> users;

  AppStateUpdateUsers({this.users});

  @override
  List<Object> get props => [users];
}

class AppStateDeleteUsers extends AppStateEvent {
  final List<String> usersIds;

  AppStateDeleteUsers({this.usersIds});

  @override
  List<Object> get props => [usersIds];
}

class AppStateUpdatePosters extends AppStateEvent {
  final List<PosterNormalized> posters;

  AppStateUpdatePosters({this.posters});

  @override
  List<Object> get props => [posters];
}

class AppStateDeletePosters extends AppStateEvent {
  final List<String> postersIds;

  AppStateDeletePosters({this.postersIds});

  @override
  List<Object> get props => [postersIds];
}

class AppStateSavePostersResponse extends AppStateEvent {
  final PostersFetchResponse postersResponse;

  AppStateSavePostersResponse({this.postersResponse});

  @override
  List<Object> get props => [postersResponse];
}
