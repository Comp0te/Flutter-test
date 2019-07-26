import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class DrawerState extends EquatableClass {
  final int activeIndex;

  DrawerState({@required this.activeIndex})
      : super([activeIndex]);

  factory DrawerState.init() =>
      DrawerState(activeIndex: 0);

  DrawerState update({@required int activeIndex}) {
    return DrawerState(activeIndex: activeIndex);
  }
}
