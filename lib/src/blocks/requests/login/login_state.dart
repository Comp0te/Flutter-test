import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class EquatableState extends Equatable {
  EquatableState([List props = const []]) : super(props);
}

@immutable
class LoginState extends EquatableState {
  final bool isLoading;
  final LoginResponse data;
  final Exception error;

  bool get isSuccess => data != null;
  bool get isFailure => error != null;

  LoginState({
    @required this.isLoading,
    this.data,
    this.error,
  }) : super([isLoading, data, error]);

  factory LoginState.init() {
    return LoginState(
      isLoading: false,
    );
  }

  LoginState update({
    @required bool isLoading,
    LoginResponse data,
    Exception error,
  }) {
    return LoginState(
      isLoading: isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
