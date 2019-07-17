import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/blocks/blocks.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onPressSubmit() {
      _fbKey.currentState.save();

      if (_fbKey.currentState.validate()) {
        _loginBloc.dispatch(LoginRequest(
          email: _emailController.text,
          password: _passwordController.text,
        ));
      }
    }

//    toRegistrationScreen() {
//      return Navigator.of(context).pushNamed(RouteNames.register);
//    }

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener(
        bloc: _loginBloc,
        condition: (LoginState prev, LoginState cur) => prev != cur,
        listener: (BuildContext context, LoginState state) {
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
          }

          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 3),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Login Failure: ${(state.error as DioError).message}', ),
                      Icon(Icons.error),
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (BuildContext context, LoginState state) {
            return SingleChildScrollView(
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
                          controller: _emailController,
                          attribute: 'email',
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: "Email"),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ],
                        ),
                        FormBuilderTextField(
                          controller: _passwordController,
                          attribute: 'password',
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(
                              8,
                              errorText: "Min 8 characters",
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 80),
                          child: RaisedButton(
                            onPressed:
                                state.isLoading ? null : _onPressSubmit,
                            elevation: 3,
                            disabledColor: Colors.blueGrey,
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
            );
          },
        ),
      ),
    );
  }
}
