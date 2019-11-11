import 'package:flutter/material.dart';

import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class NavigationState extends EquatableClass {
  final int activeDrawerIndex;
  final List<DrawerItemOptions> mainDrawerItemOptions;

  NavigationState({
    @required this.activeDrawerIndex,
    this.mainDrawerItemOptions,
  });

  factory NavigationState.init() => NavigationState(
        activeDrawerIndex: 0,
        mainDrawerItemOptions: [],
      );

  NavigationState copyWith({
    int activeDrawerIndex,
    List<DrawerItemOptions> mainDrawerItemOptions,
  }) {
    return NavigationState(
      activeDrawerIndex: activeDrawerIndex ?? this.activeDrawerIndex,
      mainDrawerItemOptions:
          mainDrawerItemOptions ?? this.mainDrawerItemOptions,
    );
  }

  @override
  List<Object> get props => [activeDrawerIndex, mainDrawerItemOptions];
}
