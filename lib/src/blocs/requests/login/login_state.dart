import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class LoginState extends EquatableClass {
  final bool isLoading;
  final AuthResponse data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  LoginState({
    @required this.isLoading,
    this.data,
    this.error,
  }) : super([isLoading, data, error]);

  factory LoginState.init() => LoginState(isLoading: false);

  LoginState update({
    @required bool isLoading,
    AuthResponse data,
    Exception error,
  }) {
    return LoginState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
