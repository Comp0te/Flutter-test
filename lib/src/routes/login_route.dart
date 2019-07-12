import 'package:flutter/material.dart';
import 'package:flutter_app/src/utils/constants.dart';

import 'package:flutter_app/src/widgets/auth_form_field.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  var email = '';
  var password = '';

  onChangeEmail(String value) {
    email = value;
  }

  onChangePassword(String value) {
    password = value;
  }

  toRegistrationScreen() => Navigator.of(context).pushNamed(RouteNames.register);

  @override
  Widget build(BuildContext context) {
    _onPress() => print('email - $email, password - $password');

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                "https://cdn.pixabay.com/photo/2019/07/06/03/30/sand-dune-4319681_960_720.jpg",
                fit: BoxFit.contain,
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
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: RaisedButton(
                  onPressed: _onPress,
                  elevation: 3,
                  color: Theme.of(context).accentColor,
                  child: Text('Submit'),
                ),
              ),
              GestureDetector(
                onTap: toRegistrationScreen,
                child: Text("To registration screen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
