import 'package:flutter/material.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/models/model.dart';
import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class MainDrawerState extends EquatableClass {
  final int activeDrawerIndex;
  final List<DrawerItemOptions> drawerItemOptions;

  MainDrawerState({
    @required this.activeDrawerIndex,
    this.drawerItemOptions = mainDrawerItemOptions
  });

  factory MainDrawerState.init() => MainDrawerState(activeDrawerIndex: 0);

  MainDrawerState copyWith({
    @required int activeDrawerIndex,
    List<DrawerItemOptions> drawerItemOptions,
  }) {
    return MainDrawerState(
      activeDrawerIndex: activeDrawerIndex,
      drawerItemOptions: drawerItemOptions ?? this.drawerItemOptions,
    );
  }

  @override
  List<Object> get props => [activeDrawerIndex];
}
