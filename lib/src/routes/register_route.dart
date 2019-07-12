import 'package:flutter/material.dart';

import 'package:flutter_app/src/widgets/auth_form_field.dart';

class RegisterRoute extends StatefulWidget {
  @override
  RegisterRouteState createState() => RegisterRouteState();
}

class RegisterRouteState extends State<RegisterRoute> {
  String _userName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

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
    _onPress() => print(
          'user name - $_userName, email - $_email,'
          'password - $_password, confirmpassword - $_confirmPassword',
        );

    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: SingleChildScrollView(
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
    );
  }
}
