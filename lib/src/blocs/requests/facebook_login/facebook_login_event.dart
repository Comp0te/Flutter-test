import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
abstract class FacebookLoginEvent extends Equatable implements RequestEvent {
  const FacebookLoginEvent();

  @override
  List<Object> get props => [];
}

class FacebookLoginRequest extends FacebookLoginEvent {}
