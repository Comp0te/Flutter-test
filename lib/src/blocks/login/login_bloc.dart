import 'dart:async';

import 'package:flutter_app/src/models/model.dart';
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
      yield* _mapLoginButtonPressedToState(event);
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

  Stream<LoginState> _mapLoginButtonPressedToState(LoginInput data) async* {
    yield LoginState.loading();
    try {
      var loginResponse = await loginRepository.login(data);
      await authRepository.saveToken(loginResponse.token);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
