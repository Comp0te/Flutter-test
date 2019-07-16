import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  LoginState.initialState({
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  factory LoginState.empty() {
    return LoginState.initialState();
  }

  factory LoginState.loading() {
    return LoginState.initialState(
      isSubmitting: true,
    );
  }

  factory LoginState.failure() {
    return LoginState.initialState(
      isFailure: true,
    );
  }

  factory LoginState.success() {
    return LoginState.initialState(
      isSuccess: true,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return LoginState.initialState(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
    );
  }
}
