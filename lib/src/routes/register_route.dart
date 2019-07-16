import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/validators.dart';

import 'package:flutter_app/src/widgets/auth_form_field.dart';

class RegisterRoute extends StatefulWidget {
  @override
  RegisterRouteState createState() => RegisterRouteState();
}

class RegisterRouteState extends State<RegisterRoute> {
  var _userName = '';
  var _email = '';
  var _password = '';
  var _confirmPassword = '';
  final _formKey = GlobalKey<FormState>();

  void onChangeUserName(String value) {
    _userName = value;
  }

  void onChangeEmail(String value) {
    _email = value;
  }

  void onChangePassword(String value) {
    _password = value;
  }

  void onChangeConfirmPassword(String value) {
    _confirmPassword = value;
  }

  @override
  Widget build(BuildContext context) {
    _onPress() {
      if (_formKey.currentState.validate()) {
        print(
          'user name - $_userName, email - $_email,'
          'password - $_password, confirmpassword - $_confirmPassword',
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AuthFormField(
                  label: "User Name",
                  onChangeText: onChangeUserName,
                ),
                AuthFormField(
                  label: "Email",
                  onChangeText: onChangeEmail,
                  validator: Validators.email,
                ),
                AuthFormField(
                  label: "Password",
                  onChangeText: onChangePassword,
                  isObscureText: true,
                ),
                AuthFormField(
                  label: "Confirm Password",
                  onChangeText: onChangeConfirmPassword,
                  isObscureText: true,
                ),
                RaisedButton(
                  onPressed: _onPress,
                  elevation: 3,
                  color: Theme.of(context).accentColor,
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
