import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActiveIndexEvent extends Equatable {
  ActiveIndexEvent([List props = const []]) : super(props);
}

class SetActiveIndex extends ActiveIndexEvent {
  final int activeIndex;

  SetActiveIndex({this.activeIndex})
      : super([activeIndex]);
}
