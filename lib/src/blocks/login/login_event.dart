import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);
}

class Submitted extends LoginEvent implements LoginInput {
  final String email;
  final String password;

  Submitted({@required this.email, @required this.password})
      : super([email, password]);
}

class LoginButtonPressed extends LoginEvent implements LoginInput {
  final String email;
  final String password;

  LoginButtonPressed({@required this.email, @required this.password})
      : super([email, password]);
}
