import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

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
