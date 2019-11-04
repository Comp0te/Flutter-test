import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class IntValueEvent extends Equatable {
  const IntValueEvent();
}

class SetIntValue extends IntValueEvent {
  final int value;

  const SetIntValue(this.value);

  @override
  List<Object> get props => [value];
}
