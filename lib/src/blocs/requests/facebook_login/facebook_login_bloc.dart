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
  FacebookLoginState get initialState => FacebookLoginInitial();

  @override
  Stream<FacebookLoginState> mapEventToState(FacebookLoginEvent event) async* {
    if (event is FacebookLoginRequest) {
      yield* _mapFacebookLoginRequestToState(event);
    }
  }

  Stream<FacebookLoginState> _mapFacebookLoginRequestToState(
      FacebookLoginRequest event) async* {
    yield FacebookLoginLoading();

    try {
      final response = await authRepository.facebookLogin();

      if (response != null) {
        yield FacebookLoginSuccessful(data: response);
      } else {
        yield FacebookLoginInitial();
      }
    } on Exception catch (error) {
      yield FacebookLoginFailed(error: error);
    }
  }
}
