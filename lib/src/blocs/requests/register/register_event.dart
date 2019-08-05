import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  RegisterEvent([List props = const []]) : super(props);
}

class RegisterRequestInit extends RegisterEvent {}

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
  }) : super([username, email, password1, password2]);
}

class RegisterRequestSuccess extends RegisterEvent {
  final AuthResponse registerResponse;

  RegisterRequestSuccess({@required this.registerResponse})
      : super([registerResponse]);
}

class RegisterRequestFailure extends RegisterEvent {
  final Exception error;

  RegisterRequestFailure({@required this.error}) : super([error]);
}
