import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterRequestInit extends RegisterEvent implements RequestInit {
  @override
  List<Object> get props => [];
}

class RegisterRequest extends RegisterEvent {
  final String username;
  final String email;
  final String password1;
  final String password2;

  RegisterRequest({
    this.username,
    @required this.email,
    @required this.password1,
    @required this.password2,
  });

  @override
  List<Object> get props => [username, email, password1, password2];
}

class RegisterRequestSuccess extends RegisterEvent
    implements RequestSuccess<AuthResponse> {
  @override
  final AuthResponse response;

  RegisterRequestSuccess({@required this.response});

  @override
  List<Object> get props => [response];
}

class RegisterRequestFailure extends RegisterEvent implements RequestFailure {
  @override
  final Exception error;

  RegisterRequestFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
