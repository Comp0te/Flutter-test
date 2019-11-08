import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';
import 'package:flutter_app/src/models/model.dart';

@immutable
abstract class FacebookLoginEvent extends Equatable {
  const FacebookLoginEvent();
}

class FacebookLoginRequest extends FacebookLoginEvent {
  const FacebookLoginRequest();

  @override
  List<Object> get props => [];
}

class FacebookLoginRequestSuccess extends FacebookLoginEvent
    implements RequestSuccess<AuthResponse> {
  @override
  final AuthResponse response;

  const FacebookLoginRequestSuccess({@required this.response});

  @override
  List<Object> get props => [response];
}

class FacebookLoginRequestFailure extends FacebookLoginEvent
    implements RequestFailure {
  @override
  final Exception error;

  const FacebookLoginRequestFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
