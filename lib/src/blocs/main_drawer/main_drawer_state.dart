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
    this.drawerItemOptions = const [
      DrawerItemOptions(
        title: 'Home',
        icon: Icon(Icons.home),
        routeName: MainRouteNames.home,
      ),
      DrawerItemOptions(
        title: 'Database',
        icon: Icon(Icons.storage),
        routeName: MainRouteNames.database,
      ),
      DrawerItemOptions(
        title: 'Camera',
        icon: Icon(Icons.camera),
        routeName: MainRouteNames.camera,
      ),
      DrawerItemOptions(
        title: 'Google maps',
        icon: Icon(Icons.map),
        routeName: MainRouteNames.googleMap,
      ),
    ],
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
