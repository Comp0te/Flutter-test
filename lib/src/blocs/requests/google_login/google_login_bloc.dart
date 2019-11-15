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
  GoogleLoginState get initialState => GoogleLoginInitial();

  @override
  Stream<GoogleLoginState> mapEventToState(GoogleLoginEvent event) async* {
    if (event is GoogleLoginRequest) {
      yield* _mapGoogleLoginRequestToState(event);
    }
  }

  Stream<GoogleLoginState> _mapGoogleLoginRequestToState(
      GoogleLoginRequest event) async* {
    yield GoogleLoginLoading();

    try {
      final response = await authRepository.googleLogin();

      yield GoogleLoginSuccessful(data: response);
    } on Exception catch (error) {
      yield GoogleLoginFailed(error: error);
    }
  }
}
