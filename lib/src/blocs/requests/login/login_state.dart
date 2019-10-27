import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class LoginState extends EquatableClass implements RequestState<AuthResponse> {
  @override
  final bool isLoading;
  @override
  final AuthResponse data;
  @override
  final Exception error;

  LoginState({
    @required this.isLoading,
    this.data,
    this.error,
  });

  @override
  bool get isSuccess => data != null;
  @override
  bool get isFailure => error != null;

  factory LoginState.init({bool isLoading = false}) =>
      LoginState(isLoading: isLoading);

  @override
  LoginState copyWith({
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

  @override
  List<Object> get props => [isLoading, data, error];
}
