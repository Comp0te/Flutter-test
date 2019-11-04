import 'package:meta/meta.dart';

import 'package:flutter_app/src/abstracts/abstracts.dart';

@immutable
class FormValidationState extends EquatableClass {
  final bool isFormAutoValidate;

  FormValidationState({@required this.isFormAutoValidate});

  factory FormValidationState.init() =>
      FormValidationState(isFormAutoValidate: false);

  FormValidationState copyWith({@required bool isFormAutoValidate}) {
    return FormValidationState(isFormAutoValidate: isFormAutoValidate);
  }

  @override
  List<Object> get props => [isFormAutoValidate];
}
