import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SecureStorageRepository secureStorageRepository;
  final AuthRepository authRepository;

  RegisterBloc({
    @required this.secureStorageRepository,
    @required this.authRepository,
  })  : assert(secureStorageRepository != null),
        assert(authRepository != null);

  @override
  RegisterState get initialState => RegisterState.init();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterRequestInit) {
      yield RegisterState.init();
    } else if (event is RegisterRequest) {
      yield* _mapRegisterRequestToState(event);
    } else if (event is RegisterRequestSuccess) {
      yield* _mapRegisterRequestSuccessToState(event);
    } else if (event is RegisterRequestFailure) {
      yield* _mapRegisterRequestFailureToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterRequestToState(RegisterRequest event) async* {
    yield state.copyWith(
      isLoading: true,
    );

    try {
      final registerResponse = await authRepository.register(RegisterInput(
        username: event.username,
        email: event.email,
        password1: event.password1,
        password2: event.password2,
      ));

      add(RegisterRequestSuccess(response: registerResponse));
    } on Exception catch (err) {
      add(RegisterRequestFailure(error: err));
    }
  }

  Stream<RegisterState> _mapRegisterRequestSuccessToState(
    RegisterRequestSuccess event,
  ) async* {
    await secureStorageRepository.saveToken(event.response.token);

    yield state.copyWith(
      isLoading: false,
      data: event.response,
    );
    authRepository.addAuthHeader(event.response.token);
  }

  Stream<RegisterState> _mapRegisterRequestFailureToState(
    RegisterRequestFailure event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      error: event.error,
    );
  }
}
