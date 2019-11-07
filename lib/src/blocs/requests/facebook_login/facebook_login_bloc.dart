import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/repositories/repositories.dart';

class FacebookLoginBloc extends Bloc<FacebookLoginEvent, FacebookLoginState> {
  final AuthRepository authRepository;

  FacebookLoginBloc({
    @required this.authRepository,
  }) : assert(authRepository != null);

  @override
  FacebookLoginState get initialState => FacebookLoginState.init();

  @override
  Stream<FacebookLoginState> mapEventToState(FacebookLoginEvent event) async* {
    if (event is FacebookLoginRequest) {
      yield* _mapFacebookLoginRequestToState(event);
    } else if (event is FacebookLoginRequestSuccess) {
      yield* _mapFacebookLoginRequestSuccessToState(event);
    } else if (event is FacebookLoginRequestFailure) {
      yield* _mapFacebookLoginRequestFailureToState(event);
    }
  }

  Stream<FacebookLoginState> _mapFacebookLoginRequestToState(
      FacebookLoginRequest event) async* {
    yield FacebookLoginState.init(isLoading: true);

    try {
      final response = await authRepository.facebookLogin();

      if (response != null) {
        print('${response}');
        add(FacebookLoginRequestSuccess(response: response));
      } else {
        yield FacebookLoginState.init();
      }
    } on Exception catch (err) {
      add(FacebookLoginRequestFailure(error: err));
    }
  }

  Stream<FacebookLoginState> _mapFacebookLoginRequestSuccessToState(
    FacebookLoginRequestSuccess event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      data: event.response,
    );
  }

  Stream<FacebookLoginState> _mapFacebookLoginRequestFailureToState(
    FacebookLoginRequestFailure event,
  ) async* {
    yield state.copyWith(
      isLoading: false,
      error: event.error,
    );
  }
}
