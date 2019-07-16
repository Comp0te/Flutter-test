import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class EquatableState extends Equatable {
  EquatableState([List props = const []]) : super(props);
}

@immutable
class LoginState extends EquatableState {
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  LoginState({
    @required this.email,
    @required this.password,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  }) : super([email, password, isFailure, isSuccess, isSubmitting]);

  factory LoginState.init() {
    return LoginState(
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

//  factory LoginState.loading(bool isSubmitting) {
//    return copyWith(isSubmitting: isSubmitting);
//  }
//
//  factory LoginState.failure() {
//    return copyWith(isFailure: true);
//  }
//
//  factory LoginState.success() {
//    return copyWith(isSuccess: true);
//  }

//  LoginState update({
//    String email,
//    String password,
//    bool isSubmitting,
//    bool isSuccess,
//    bool isFailure,
//  }) {
//    return copyWith(
//      email: email,
//      password: password,
//      isFailure: isFailure,
//      isSuccess: isSuccess,
//      isSubmitting: isSubmitting,
//    );
//  }

  LoginState update({
    String email,
    String password,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
