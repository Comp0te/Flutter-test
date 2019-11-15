import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterRequest) {
      yield* _mapRegisterRequestToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterRequestToState(
      RegisterRequest event) async* {
    yield RegisterLoading();

    try {
      final registerResponse = await authRepository.register(RegisterInput(
        username: event.username,
        email: event.email,
        password1: event.password1,
        password2: event.password2,
      ));

      yield RegisterSuccessful(data: registerResponse);
    } on Exception catch (error) {
      yield RegisterFailed(error: error);
    }
  }
}
