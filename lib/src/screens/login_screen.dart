import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/blocks/blocks.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  bool isLoginButtonEnabled(LoginState state) {
    return !state.isSubmitting;
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    void onChangeEmail(value) {
      if (value is String) {
        print('onChangeEmail ==========');
        _loginBloc.dispatch(EmailChanged(email: value));
      }
    }

    onChangePassword(value) {
      if (value is String) {
        print('onChangePassword ==========');
        _loginBloc.dispatch(PasswordChanged(password: value));
      }
    }

//    toRegistrationScreen() {
//      return Navigator.of(context).pushNamed(RouteNames.register);
//    }

    _onPress() {
      _fbKey.currentState.save();

      if (_fbKey.currentState.validate()) {
        print(_fbKey.currentState.value);
        _fbKey.currentState.value.forEach((key, val) => print('$key - $val'));
        _loginBloc.dispatch(
          Submitted(
            email: null,
            password: null,
          ),
        );
      }
    }

//    void _onFormSubmitted() {
////      _loginBloc.dispatch(
////        LoginButtonPressed(
////          email: _loginBloc.currentState,
////          password: _passwordController.text,
////        ),
////      );
//    }

    return BlocBuilder(
      bloc: BlocProvider.of<LoginBloc>(context),
      builder: (BuildContext context, LoginState state) {
        return Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  autovalidate: true,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: 'email',
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: "Email"),
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ],
                        onChanged: onChangeEmail,
                      ),
                      FormBuilderTextField(
                        attribute: 'password',
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(
                            8,
                            errorText: "Min 8 characters",
                          ),
                        ],
                        onChanged: onChangePassword,
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
//                    GestureDetector(
//                      onTap: toRegistrationScreen,
//                      child: Text("To registration screen"),
//                    )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
