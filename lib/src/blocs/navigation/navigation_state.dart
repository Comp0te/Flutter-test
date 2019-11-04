import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class NavigationState extends EquatableClass {
  final int activeDrawerIndex;
  final List<DrawerItemOptions> drawerItemOptions;

  NavigationState({
    @required this.activeDrawerIndex,
    this.drawerItemOptions = mainDrawerItemOptions,
  });

  factory NavigationState.init() => NavigationState(activeDrawerIndex: 0);

  NavigationState copyWith({
    @required int activeDrawerIndex,
    List<DrawerItemOptions> drawerItemOptions,
  }) {
    return NavigationState(
      activeDrawerIndex: activeDrawerIndex,
      drawerItemOptions: drawerItemOptions ?? this.drawerItemOptions,
    );
  }

  @override
  List<Object> get props => [activeDrawerIndex];
}
