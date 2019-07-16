import 'package:flutter/material.dart';

import 'package:flutter_app/src/utils/validators.dart';

typedef onChangeTextCallback = void Function(String value);

class AuthFormField extends StatefulWidget {
  final String label;
  final bool isObscureText;
  final onChangeTextCallback onChangeText;
  final ValidatorFn<String> validator;

  AuthFormField({
    @required this.label,
    @required this.onChangeText,
    this.validator,
    this.isObscureText = false,
  });

  @override
  _AuthFormFieldState createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  final inputController = TextEditingController();
//  final StreamController<String> _streamController = StreamController<String>();

  @override
  void initState() {
    super.initState();

    inputController.addListener(_setInputValue);
  }

  @override
  void dispose() {
    inputController.dispose();
//    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: TextFormField(
            controller: inputController,
            decoration: InputDecoration(
              labelText: widget.label,
            ),
            obscureText: widget.isObscureText,
            autovalidate: true,
            autocorrect: false,
            validator: widget.validator,
          ),
          margin: EdgeInsets.only(bottom: 20),
        ),
      ],
    );
  }

  _setInputValue() {
    widget.onChangeText(inputController.text);
//    _streamController.sink.add(inputController.text);
  }
}
