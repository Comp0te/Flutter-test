import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocks/blocks.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  @override
  FormValidationState get initialState => FormValidationState.init();

  @override
  Stream<FormValidationState> mapEventToState(
    FormValidationEvent event,
  ) async* {
    if (event is ToggleFormAutoValidation) {
      yield currentState.update(
        isFormAutoValidate: !currentState.isFormAutoValidate,
      );
    }
  }
}
