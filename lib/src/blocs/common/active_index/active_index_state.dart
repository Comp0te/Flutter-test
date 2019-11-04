import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class ActiveIndexState extends EquatableClass {
  final int activeIndex;

  ActiveIndexState({@required this.activeIndex});

  factory ActiveIndexState.init(int initialIndex) =>
      ActiveIndexState(activeIndex: initialIndex ?? 0);

  ActiveIndexState copyWith({@required int activeIndex}) {
    return ActiveIndexState(activeIndex: activeIndex);
  }

  @override
  List<Object> get props => [activeIndex];
}
