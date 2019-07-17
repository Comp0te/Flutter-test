import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class EquatableClass extends Equatable {
  EquatableClass([List props = const []]) : super(props);
}