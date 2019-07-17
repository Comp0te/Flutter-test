import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SecureStorageRepository secureStorageRepository;
  final AuthRepository authRepository;

  LoginBloc({
    @required this.secureStorageRepository,
    @required this.authRepository,
  })  : assert(secureStorageRepository != null),
        assert(authRepository != null);

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
      var loginResponse = await authRepository.login(LoginInput(
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
    await secureStorageRepository.saveToken(event.loginResponse.token);

    yield currentState.update(
      isLoading: false,
      data: event.loginResponse,
    );
    authRepository.addAuthHeader(event.loginResponse.token);
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
