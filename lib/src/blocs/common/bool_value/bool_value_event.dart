import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BoolValueEvent extends Equatable {
  const BoolValueEvent();

  @override
  List<Object> get props => [];
}

class ToggleBoolValue extends BoolValueEvent {}

class SetBoolValue extends BoolValueEvent {
  final bool value;

  const SetBoolValue(this.value);

  @override
  List<Object> get props => [value];
}
