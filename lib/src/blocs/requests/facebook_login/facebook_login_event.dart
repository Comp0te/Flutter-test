import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FacebookLoginEvent extends Equatable {
  const FacebookLoginEvent();

  @override
  List<Object> get props => [];
}

class FacebookLoginRequest extends FacebookLoginEvent {}
