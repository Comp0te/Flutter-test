import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class AuthState extends EquatableClass {
  final bool isAuthenticated;

  AuthState({@required this.isAuthenticated}) : super([isAuthenticated]);

  factory AuthState.init() => AuthState(isAuthenticated: false);

  AuthState copyWith({@required bool isAuthenticated}) {
    return AuthState(isAuthenticated: isAuthenticated);
  }
}