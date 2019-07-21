import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormFieldUserName extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final List<FormFieldValidator> validatorsList;

  const FormFieldUserName({
    Key key,
    @required this.controller,
    this.label = "User Name",
    this.validatorsList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      constraints: BoxConstraints(maxHeight: 60),
      child: FormBuilderTextField(
        controller: controller,
        attribute: label,
        autocorrect: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          labelText: label,
          icon: Icon(Icons.person_outline),
        ),
        validators: [
          ...validatorsList,
        ],
      ),
    );
  }
}
