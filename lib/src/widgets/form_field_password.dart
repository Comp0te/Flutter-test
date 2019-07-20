import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const FormFieldPassword({
    Key key,
    @required this.controller,
    this.label = "Password",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 50),
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
        ],
      ),
    );
  }
}
