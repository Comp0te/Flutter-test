import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter_app/src/blocs/blocs.dart';

class FormValidationBloc
    extends Bloc<FormValidationEvent, FormValidationState> {
  @override
  FormValidationState get initialState => FormValidationState.init();

  @override
  Stream<FormValidationState> mapEventToState(
    FormValidationEvent event,
  ) async* {
    if (event is ToggleFormAutoValidation) {
      yield state.copyWith(
        isFormAutoValidate: !state.isFormAutoValidate,
      );
    }
  }
}
