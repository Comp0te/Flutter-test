import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
abstract class GoogleLoginEvent extends Equatable implements RequestEvent {
  const GoogleLoginEvent();

  @override
  List<Object> get props => [];
}

class GoogleLoginRequest extends GoogleLoginEvent {}
