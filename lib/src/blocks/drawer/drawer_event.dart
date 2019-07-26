import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DrawerEvent extends Equatable {
  DrawerEvent([List props = const []]) : super(props);
}

class SetDrawerActiveIndex extends DrawerEvent {
  final int activeIndex;

  SetDrawerActiveIndex({this.activeIndex})
      : super([activeIndex]);
}
