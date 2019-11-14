import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class GoogleLoginState extends Equatable implements RequestState {
  const GoogleLoginState();

  @override
  List<Object> get props => [];
}

class GoogleLoginInitial extends GoogleLoginState implements RequestInitial {}

class GoogleLoginLoading extends GoogleLoginState implements RequestLoading {}

class GoogleLoginSuccessful extends GoogleLoginState
    implements RequestSuccessful<AuthResponse> {
  @override
  final AuthResponse data;

  const GoogleLoginSuccessful({this.data});

  @override
  List<Object> get props => [data];
}

class GoogleLoginFailed extends GoogleLoginState implements RequestFailed {
  @override
  final Exception error;

  const GoogleLoginFailed({this.error});

  @override
  List<Object> get props => [error];
}