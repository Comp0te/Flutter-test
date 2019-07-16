import 'dart:async';

import 'package:flutter_app/src/models/model.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_app/src/blocks/blocks.dart';
import 'package:flutter_app/src/repositories/repositories.dart';
import 'package:flutter_app/src/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final LoginRepository loginRepository;

  LoginBloc({
    @required this.authRepository,
    @required this.loginRepository,
  })  : assert(authRepository != null),
        assert(loginRepository != null);

  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transform(
    Stream<LoginEvent> events,
    Stream<LoginState> next(LoginEvent event),
  ) {
    final Observable<LoginEvent> observableStream = events;
    final nonDebounceStream = observableStream.where(
        (event) => (event is! EmailChanged && event is! PasswordChanged));

    final debounceStream = observableStream
        .where((event) => (event is EmailChanged || event is PasswordChanged))
        .debounceTime(Duration(milliseconds: 300));

    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isEmpty(email) && Validators.isEmailValid(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid:
          Validators.isEmpty(password) && Validators.isPasswordValid(password),
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
