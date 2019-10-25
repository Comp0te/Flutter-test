import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/auth/bloc.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageRepository secureStorageRepository;
  final AuthRepository authRepository;

  AuthBloc({
    @required this.secureStorageRepository,
    @required this.authRepository,
  })  : assert(secureStorageRepository != null),
        assert(authRepository != null);

  @override
  AuthState get initialState => AuthState.init();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final hasToken = await secureStorageRepository.hasToken();

      if (hasToken) {
        yield state.copyWith(isAuthenticated: true);
      }
    }

    if (event is LoggedIn) {
      yield state.copyWith(isAuthenticated: true);
    }

    if (event is LoggedOut) {
      yield state.copyWith(isAuthenticated: false);
      await secureStorageRepository.deleteToken();
    }
  }
}
