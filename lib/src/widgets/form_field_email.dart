import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/generated/i18n.dart';

class FormFieldEmail extends StatelessWidget {
  final TextEditingController controller;
  final String attribute;
  final List<FormFieldValidator> validatorsList;
  final ValueChanged<String> onFiledSubmitted;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  const FormFieldEmail({
    Key key,
    @required this.controller,
    this.attribute = "Email",
    this.validatorsList = const [],
    this.onFiledSubmitted,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      constraints: const BoxConstraints(maxHeight: 60),
      child: FormBuilderTextField(
        controller: controller,
        attribute: attribute,
        autocorrect: false,
        focusNode: focusNode,
        keyboardType: TextInputType.emailAddress,
        textInputAction: textInputAction,
        onFieldSubmitted: onFiledSubmitted,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          labelText: S.of(context).email,
          icon: Icon(Icons.alternate_email),
        ),
        validators: [
          FormBuilderValidators.required(
              errorText: S.of(context).errorRequired),
          FormBuilderValidators.email(errorText: S.of(context).errorEmail),
          ...validatorsList,
        ],
      ),
    );
  }
}
