import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class ActiveIndexState extends EquatableClass {
  final int activeIndex;

  ActiveIndexState({@required this.activeIndex})
      : super([activeIndex]);

  factory ActiveIndexState.init() =>
      ActiveIndexState(activeIndex: 0);

  ActiveIndexState update({@required int activeIndex}) {
    return ActiveIndexState(activeIndex: activeIndex);
  }
}
