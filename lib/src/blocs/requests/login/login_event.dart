import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginRequestInit extends LoginEvent implements RequestInit {}

class LoginRequest extends LoginEvent {
  final String email;
  final String password;

  LoginRequest({@required this.email, @required this.password})
      : super([email, password]);
}

class LoginRequestSuccess extends LoginEvent
    implements RequestSuccess<AuthResponse> {
  @override
  final AuthResponse response;

  LoginRequestSuccess({@required this.response}) : super([response]);
}

class LoginRequestFailure extends LoginEvent implements RequestFailure {
  @override
  final Exception error;

  LoginRequestFailure({@required this.error}) : super([error]);
}
