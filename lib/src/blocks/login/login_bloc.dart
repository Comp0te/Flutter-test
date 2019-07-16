import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final LoginRepository loginRepository;

  LoginBloc({
    @required this.authRepository,
    @required this.loginRepository,
  })  : assert(authRepository != null),
        assert(loginRepository != null);

  LoginState get initialState => LoginState.init();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapLoginButtonPressedToState();
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      email: email,
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      password: password,
    );
  }

  Stream<LoginState> _mapLoginButtonPressedToState() async* {
    yield currentState.update(isSubmitting: true);
    try {
      var loginResponse = await loginRepository.login(
        Submitted(
          email: currentState.email,
          password: currentState.password,
        ),
      );

      print('loginResponse ============= $loginResponse');
      await authRepository.saveToken(loginResponse.token);

      yield currentState.update(
        isSubmitting: false,
        isSuccess: true,
      );
    } catch (e) {
      print('loginError =============== $e');
      yield currentState.update(
        isSubmitting: false,
        isFailure: true,
      );
    }
  }
}
