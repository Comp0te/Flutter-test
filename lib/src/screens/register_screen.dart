import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/src/widgets/hero_register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/widgets/widgets.dart';

import 'package:flutter_app/src/utils/validators.dart';
import 'package:flutter_app/src/utils/helpers/orientation_helper.dart';
import 'package:flutter_app/src/servises/snackbar.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

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
  final FormValidationBloc _formValidationBloc = FormValidationBloc();

  BoxConstraints _getFormFieldConstraints(BuildContext context) =>
      OrientationHelper.isLandscape(context)
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.40)
          : BoxConstraints();

  @override
  Widget build(BuildContext context) {
    final RegisterBloc _registerBloc = BlocProvider.of<RegisterBloc>(context);

    VoidCallback _makeOnPressSubmit(FormValidationState state) {
      return () {
        if (_fbKey.currentState.validate()) {
          _registerBloc.dispatch(RegisterRequest(
            username: _usernameController.text,
            email: _emailController.text,
            password1: _password1Controller.text,
            password2: _password2Controller.text,
          ));
        } else if (!state.isFormAutoValidate) {
          _formValidationBloc.dispatch(ToggleFormAutoValidation());
        }
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        centerTitle: true,
      ),
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

            _registerBloc.dispatch(RegisterRequestInit());
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeroRegister(
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: BlocBuilder(
                      bloc: _formValidationBloc,
                      builder: (
                        BuildContext context,
                        FormValidationState formValidationState,
                      ) {
                        return FormBuilder(
                          key: _fbKey,
                          autovalidate: formValidationState.isFormAutoValidate,
                          child: Column(
                            children: <Widget>[
                              Flex(
                                direction:
                                    OrientationHelper.isLandscape(context)
                                        ? Axis.horizontal
                                        : Axis.vertical,
                                mainAxisSize:
                                    OrientationHelper.isLandscape(context)
                                        ? MainAxisSize.max
                                        : MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    constraints:
                                        _getFormFieldConstraints(context),
                                    child: FormFieldEmail(
                                      controller: _usernameController,
                                    ),
                                  ),
                                  Container(
                                    constraints:
                                        _getFormFieldConstraints(context),
                                    child: FormFieldPassword(
                                      controller: _emailController,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Flex(
                                  direction:
                                      OrientationHelper.isLandscape(context)
                                          ? Axis.horizontal
                                          : Axis.vertical,
                                  mainAxisSize:
                                      OrientationHelper.isLandscape(context)
                                          ? MainAxisSize.max
                                          : MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      constraints:
                                          _getFormFieldConstraints(context),
                                      child: FormFieldEmail(
                                        label: 'Password',
                                        controller: _password1Controller,
                                      ),
                                    ),
                                    Container(
                                      constraints:
                                          _getFormFieldConstraints(context),
                                      child: FormFieldPassword(
                                        label: 'Confirm Password',
                                        controller: _password2Controller,
                                        validatorsList: [
                                          Validators
                                              .makeConfirmPasswordValidator(
                                            passwordController:
                                                _password1Controller,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              BlocBuilder(
                                bloc: _registerBloc,
                                builder: (
                                  BuildContext context,
                                  RegisterState registerState,
                                ) {
                                  return SubmitButton(
                                    isLoading: registerState.isLoading,
                                    title: 'Submit',
                                    onPress: _makeOnPressSubmit(
                                      formValidationState,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
