import 'package:equatable/equatable.dart';
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
