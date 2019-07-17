import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
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
    if (event is LoginRequest) {
      yield* _mapLoginRequestToState(event);
    } else if (event is LoginRequestSuccess) {
      yield* _mapLoginRequestSuccessToState(event);
    } else if (event is LoginRequestFailure) {
      yield* _mapLoginRequestFailureToState(event);
    }
  }

  Stream<LoginState> _mapLoginRequestToState(LoginRequest event) async* {
    yield currentState.update(
      isLoading: true,
    );

    try {
      var loginResponse = await loginRepository.login(LoginInput(
        email: event.email,
        password: event.password,
      ));

      dispatch(LoginRequestSuccess(loginResponse: loginResponse));
    } catch (err) {
      dispatch(LoginRequestFailure(error: err));
    }
  }

  Stream<LoginState> _mapLoginRequestSuccessToState(
    LoginRequestSuccess event,
  ) async* {
    await authRepository.saveToken(event.loginResponse.token);

    yield currentState.update(
      isLoading: false,
      data: event.loginResponse,
    );
  }

  Stream<LoginState> _mapLoginRequestFailureToState(
    LoginRequestFailure event,
  ) async* {
    yield currentState.update(
      isLoading: false,
      error: event.error,
    );
  }
}
