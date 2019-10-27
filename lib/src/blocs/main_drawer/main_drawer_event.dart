import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainDrawerEvent extends Equatable {
  const MainDrawerEvent();
}

class SetMainDrawerRoute extends MainDrawerEvent {
  final String routeName;

  SetMainDrawerRoute({this.routeName});

  @override
  List<Object> get props => [routeName];
}
