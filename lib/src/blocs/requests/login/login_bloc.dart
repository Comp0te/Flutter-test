import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginRequest) {
      yield* _mapLoginRequestToState(event);
    }
  }

  Stream<LoginState> _mapLoginRequestToState(LoginRequest event) async* {
    yield LoginLoading();

    try {
      final response = await authRepository.login(LoginInput(
        email: event.email,
        password: event.password,
      ));

      yield LoginSuccessful(data: response);
    } on Exception catch (error) {
      yield LoginFailed(error: error);
    }
  }
}
