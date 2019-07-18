import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/servises/snackbar.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);

    _onPressSubmit() {
      _fbKey.currentState.save();

      if (_fbKey.currentState.validate()) {
        _registerBloc.dispatch(RegisterRequest(
          username: _usernameController.text,
          email: _emailController.text,
          password1: _password1Controller.text,
          password2: _password2Controller.text,
        ));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: BlocListener(
        bloc: _registerBloc,
        condition: (RegisterState prev, RegisterState cur) {
          return !prev.isFailure && prev.isFailure != cur.isFailure ||
              prev.isSuccess != cur.isSuccess;
        },
        listener: (BuildContext context, RegisterState state) {
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
          }

          if (state.isFailure) {
            SnackBarService.showError(
              context: context,
              error: state.error,
            );
            BlocProvider.of<RegisterBloc>(context)
                .dispatch(RegisterRequestInit());
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FormBuilder(
                  key: _fbKey,
                  autovalidate: false,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        controller: _usernameController,
                        attribute: 'username',
                        autocorrect: false,
                        maxLength: 20,
                        decoration: InputDecoration(labelText: "User Name"),
                      ),
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
                        controller: _password1Controller,
                        attribute: 'password1',
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
                      FormBuilderTextField(
                        controller: _password2Controller,
                        attribute: 'password2',
                        autocorrect: false,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: "Confirm Password"),
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(
                            8,
                            errorText: "Min 8 characters",
                          ),
                          (val) {
                            if (_password1Controller.text != val) {
                              return "Password don't match";
                            }

                            return null;
                          },
                        ],
                      ),
                      Container(
                        child: BlocBuilder(
                          bloc: _registerBloc,
                          builder: (BuildContext context, RegisterState state) {
                            return RaisedButton(
                              onPressed:
                                  state.isLoading ? null : _onPressSubmit,
                              elevation: 3,
                              disabledColor: Colors.blueGrey,
                              color: Theme.of(context).accentColor,
                              child: Text('Submit'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
