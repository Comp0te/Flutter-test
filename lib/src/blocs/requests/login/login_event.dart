import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequestInit extends LoginEvent implements RequestInit {
  @override
  List<Object> get props => [];
}

class LoginRequest extends LoginEvent {
  final String email;
  final String password;

  LoginRequest({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginRequestSuccess extends LoginEvent
    implements RequestSuccess<AuthResponse> {
  @override
  final AuthResponse response;

  LoginRequestSuccess({@required this.response});

  @override
  List<Object> get props => [response];
}

class LoginRequestFailure extends LoginEvent implements RequestFailure {
  @override
  final Exception error;

  LoginRequestFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
