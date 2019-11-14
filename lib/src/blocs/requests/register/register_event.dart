import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequest extends RegisterEvent {
  final String username;
  final String email;
  final String password1;
  final String password2;

  const RegisterRequest({
    this.username,
    @required this.email,
    @required this.password1,
    @required this.password2,
  });

  @override
  List<Object> get props => [username, email, password1, password2];
}
