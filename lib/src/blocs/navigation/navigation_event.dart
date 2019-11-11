import 'package:equatable/equatable.dart';
import 'package:flutter_app/src/models/drawer_item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class SetMainDrawerRoute extends NavigationEvent {
  final String routeName;

  SetMainDrawerRoute({this.routeName});

  @override
  List<Object> get props => [routeName];
}

class SetMainDrawerItemOptions extends NavigationEvent {
  final List<DrawerItemOptions> options;

  SetMainDrawerItemOptions({this.options});

  @override
  List<Object> get props => [options];
}
