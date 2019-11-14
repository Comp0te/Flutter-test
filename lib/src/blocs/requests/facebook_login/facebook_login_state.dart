import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class FacebookLoginState extends Equatable implements RequestState {
  const FacebookLoginState();

  @override
  List<Object> get props => [];
}

class FacebookLoginInitial extends FacebookLoginState
    implements RequestInitial {}

class FacebookLoginLoading extends FacebookLoginState
    implements RequestLoading {}

class FacebookLoginSuccessful extends FacebookLoginState
    implements RequestSuccessful<AuthResponse> {
  @override
  final AuthResponse data;

  const FacebookLoginSuccessful({this.data});

  @override
  List<Object> get props => [data];
}

class FacebookLoginFailed extends FacebookLoginState implements RequestFailed {
  @override
  final Exception error;

  const FacebookLoginFailed({this.error});

  @override
  List<Object> get props => [error];
}
