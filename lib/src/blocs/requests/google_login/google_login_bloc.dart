import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final AuthRepository authRepository;

  GoogleLoginBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  GoogleLoginState get initialState => GoogleLoginState.init();

  @override
  Stream<GoogleLoginState> mapEventToState(GoogleLoginEvent event) async* {
    if (event is GoogleLoginRequest) {
      yield* _mapGoogleLoginRequestToState(event);
    } else if (event is GoogleLoginRequestSuccess) {
      yield* _mapGoogleLoginRequestSuccessToState(event);
    } else if (event is GoogleLoginRequestFailure) {
      yield* _mapGoogleLoginRequestFailureToState(event);
    }
  }

  Stream<GoogleLoginState> _mapGoogleLoginRequestToState(
      GoogleLoginRequest event) async* {
    yield GoogleLoginState.init(isLoading: true);

    try {
      final response = await authRepository.googleLogin();

      add(GoogleLoginRequestSuccess(response: response));
    } on Exception catch (err) {
      add(GoogleLoginRequestFailure(error: err));
    }
  }

  Stream<GoogleLoginState> _mapGoogleLoginRequestSuccessToState(
    GoogleLoginRequestSuccess event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      data: event.response,
    );
  }

  Stream<GoogleLoginState> _mapGoogleLoginRequestFailureToState(
    GoogleLoginRequestFailure event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      error: event.error,
    );
  }
}
