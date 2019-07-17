import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class AuthState extends EquatableClass {
  final bool isAuthenticated;

  AuthState({@required this.isAuthenticated}) : super([isAuthenticated]);

  factory AuthState.init() => AuthState(isAuthenticated: false);

  AuthState update({@required bool isAuthenticated}) {
    return AuthState(isAuthenticated: isAuthenticated);
  }
}

class AuthUninitialized extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}

class AuthLoading extends AuthState {}
