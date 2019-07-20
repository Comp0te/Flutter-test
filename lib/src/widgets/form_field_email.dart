import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const FormFieldEmail({
    Key key,
    @required this.controller,
    this.label = "Email",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 50),
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
        ],
      ),
    );
  }
}
