import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FormValidationEvent extends Equatable {
  const FormValidationEvent();
}

class ToggleFormAutoValidation extends FormValidationEvent {
  @override
  List<Object> get props => [];
}

