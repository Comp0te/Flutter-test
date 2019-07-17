import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginRequestInit extends LoginEvent {}

class LoginRequest extends LoginEvent {
  final String email;
  final String password;

  LoginRequest({@required this.email, @required this.password})
      : super([email, password]);
}

class LoginRequestSuccess extends LoginEvent {
  final LoginResponse loginResponse;

  LoginRequestSuccess({@required this.loginResponse})
      : super([loginResponse]);
}

class LoginRequestFailure extends LoginEvent {
  final Exception error;

  LoginRequestFailure({@required this.error})
      : super([error]);
}
