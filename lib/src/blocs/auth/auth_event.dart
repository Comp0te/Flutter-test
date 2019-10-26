import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
