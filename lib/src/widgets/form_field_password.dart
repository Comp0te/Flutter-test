import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<FormFieldValidator> validatorsList;

  const FormFieldPassword({
    Key key,
    @required this.controller,
    this.label = "Password",
    this.validatorsList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 75),
      child: FormBuilderTextField(
        controller: controller,
        attribute: label,
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(Icons.lock_outline),
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(
            8,
            errorText: "Min 8 characters",
          ),
          ...validatorsList,
        ],
      ),
    );
  }
}
