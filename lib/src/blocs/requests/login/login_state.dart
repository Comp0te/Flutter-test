import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class LoginState extends Equatable implements RequestState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState implements RequestInitial {}

class LoginLoading extends LoginState implements RequestLoading {}

class LoginSuccessful extends LoginState
    implements RequestSuccessful<AuthResponse> {
  @override
  final AuthResponse data;

  const LoginSuccessful({this.data});

  @override
  List<Object> get props => [data];
}

class LoginFailed extends LoginState implements RequestFailed {
  @override
  final Exception error;

  const LoginFailed({this.error});

  @override
  List<Object> get props => [error];
}
