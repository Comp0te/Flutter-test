import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/models/model.dart';
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
  AuthState get initialState => AuthInit();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState(event);
    }
  }

  Stream<AuthState> _mapAppStartedToState(AppStarted event) async* {
    yield AuthLoading();

    authRepository.addTokenInterceptor(
        secureStorageRepository: secureStorageRepository,
        onLogout: () {
          add(LoggedOut());
        });

    final token = await secureStorageRepository.getToken();

    if (token != null) {
      try {
        await authRepository.verifyToken(Token(token));

        yield AuthAuthenticated();
      } on Exception catch (_) {
        add(LoggedOut());
      }
    } else {
      yield AuthUnauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState(LoggedIn event) async* {
    await secureStorageRepository.saveToken(event.authResponse.token);

    yield AuthAuthenticated();
  }

  Stream<AuthState> _mapLoggedOutToState(LoggedOut event) async* {
    yield AuthLoading();

    await secureStorageRepository.deleteToken();
    await authRepository.logout();

    yield AuthUnauthenticated();
  }
}
