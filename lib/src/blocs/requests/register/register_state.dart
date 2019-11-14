import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class RegisterState extends Equatable implements RequestState {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState implements RequestInitial {}

class RegisterLoading extends RegisterState implements RequestLoading {}

class RegisterSuccessful extends RegisterState
    implements RequestSuccessful<AuthResponse> {
  @override
  final AuthResponse data;

  const RegisterSuccessful({this.data});

  @override
  List<Object> get props => [data];
}

class RegisterFailed extends RegisterState implements RequestFailed {
  @override
  final Exception error;

  const RegisterFailed({this.error});

  @override
  List<Object> get props => [error];
}
