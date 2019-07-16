import 'package:meta/meta.dart';

@immutable
class LoginState {
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
  });

  LoginState.init({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory LoginState.loading() {
    return copyWith(isSubmitting: true);
  }

  factory LoginState.failure() {
    return copyWith(isFailure: true);
  }

  factory LoginState.success() {
    return copyWith(isSuccess: true);
  }

  LoginState update({
    String email,
    String password,
  }) {
    return copyWith(
      email: email,
      password: password,
    );
  }

  LoginState copyWith({
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
