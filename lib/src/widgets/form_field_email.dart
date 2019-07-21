import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<FormFieldValidator> validatorsList;

  const FormFieldEmail({
    Key key,
    @required this.controller,
    this.label = "Email",
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
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: label,
          icon: Icon(Icons.alternate_email),
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
          ...validatorsList,
        ],
      ),
    );
  }
}
