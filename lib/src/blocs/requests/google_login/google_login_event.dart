import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class GoogleLoginEvent extends Equatable {
  const GoogleLoginEvent();
}

class GoogleLoginRequest extends GoogleLoginEvent {
  const GoogleLoginRequest();

  @override
  List<Object> get props => [];
}

class GoogleLoginRequestSuccess extends GoogleLoginEvent
    implements RequestSuccess<AuthResponse> {
  @override
  final AuthResponse response;

  const GoogleLoginRequestSuccess({@required this.response});

  @override
  List<Object> get props => [response];
}

class GoogleLoginRequestFailure extends GoogleLoginEvent
    implements RequestFailure {
  @override
  final Exception error;

  const GoogleLoginRequestFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
