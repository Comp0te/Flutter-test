import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/auth/bloc.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageRepository secureStorageRepository;

  AuthBloc({@required this.secureStorageRepository})
      : assert(secureStorageRepository != null);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await secureStorageRepository.hasToken();

      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await secureStorageRepository.deleteToken();
      yield AuthUnauthenticated();
    }
  }
}
