import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/generated/i18n.dart';

class FormFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String attribute;
  final String label;
  final List<FormFieldValidator> validatorsList;
  final ValueChanged<String> onFiledSubmitted;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  const FormFieldPassword({
    Key key,
    @required this.controller,
    @required this.label,
    @required this.attribute,
    this.validatorsList = const [],
    this.onFiledSubmitted,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
  })  : assert(controller != null),
        assert(label != null),
        assert(attribute != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxHeight: 60),
      child: FormBuilderTextField(
        controller: controller,
        attribute: attribute,
        autocorrect: false,
        obscureText: true,
        focusNode: focusNode,
        onFieldSubmitted: onFiledSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          labelText: label,
          icon: Icon(Icons.lock_outline),
        ),
        validators: [
          FormBuilderValidators.required(
              errorText: S.of(context).errorRequired),
          FormBuilderValidators.minLength(
            8,
            errorText: S.of(context).errorMinPasswordLength,
          ),
          ...validatorsList,
        ],
      ),
    );
  }
}
