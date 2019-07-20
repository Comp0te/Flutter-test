import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FormValidationEvent extends Equatable {
  FormValidationEvent([List props = const []]) : super(props);
}

class ToggleFormAutoValidation extends FormValidationEvent {}

