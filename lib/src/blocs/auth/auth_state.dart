import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class AuthState extends EquatableClass {
  final bool isAuthenticated;

  AuthState({@required this.isAuthenticated});

  factory AuthState.init() => AuthState(isAuthenticated: false);

  AuthState copyWith({@required bool isAuthenticated}) {
    return AuthState(isAuthenticated: isAuthenticated);
  }

  @override
  List<Object> get props => [isAuthenticated];
}
