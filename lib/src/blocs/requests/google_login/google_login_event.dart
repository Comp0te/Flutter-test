import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class GoogleLoginEvent extends Equatable {
  const GoogleLoginEvent();

  @override
  List<Object> get props => [];
}

class GoogleLoginRequest extends GoogleLoginEvent {}
