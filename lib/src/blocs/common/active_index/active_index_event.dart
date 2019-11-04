import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActiveIndexEvent extends Equatable {
  const ActiveIndexEvent();
}

class SetActiveIndex extends ActiveIndexEvent {
  final int index;

  SetActiveIndex(this.index);

  @override
  List<Object> get props => [index];
}
