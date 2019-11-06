import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class AuthState extends EquatableClass {
  final bool isAuthenticated;
  final bool processing;

  AuthState({
    @required this.isAuthenticated,
    @required this.processing,
  });

  factory AuthState.init() => AuthState(
        isAuthenticated: false,
        processing: false,
      );

  AuthState copyWith({
    bool isAuthenticated,
    bool processing,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      processing: processing ?? this.processing,
    );
  }

  @override
  List<Object> get props => [isAuthenticated, processing];
}
