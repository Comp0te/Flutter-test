import 'package:meta/meta.dart';

import 'package:flutter_app/src/utils/equatable_class.dart';

@immutable
class FormValidationState extends EquatableClass {
  final bool isFormAutoValidate;

  FormValidationState({@required this.isFormAutoValidate})
      : super([isFormAutoValidate]);

  factory FormValidationState.init() =>
      FormValidationState(isFormAutoValidate: false);

  FormValidationState copyWith({@required bool isFormAutoValidate}) {
    return FormValidationState(isFormAutoValidate: isFormAutoValidate);
  }
}
