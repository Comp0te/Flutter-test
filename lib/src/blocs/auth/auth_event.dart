import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final AuthResponse authResponse;

  const LoggedIn({@required this.authResponse});

  @override
  List<Object> get props => [authResponse];
}

class LoggedOut extends AuthEvent {}
