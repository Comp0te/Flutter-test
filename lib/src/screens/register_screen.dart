import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/utils/validators.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class RegisterScreen extends StatefulWidget with OrientationMixin {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SnackBarMixin {
  final _fbKey = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _formValidationBloc = FormValidationBloc();
  final _emailFocusNode = FocusNode();
  final _password1FocusNode = FocusNode();
  final _password2FocusNode = FocusNode();

  BoxConstraints _getFormFieldConstraints(BuildContext context) =>
      widget.isLandscape(context)
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.40)
          : const BoxConstraints();

  @override
  Widget build(BuildContext context) {
    final _registerBloc = BlocProvider.of<RegisterBloc>(context);

    void _submitForm(FormValidationState state) {
      if (_fbKey.currentState.validate()) {
        _registerBloc.add(RegisterRequest(
          username: _usernameController.text,
          email: _emailController.text,
          password1: _password1Controller.text,
          password2: _password2Controller.text,
        ));
      } else if (!state.isFormAutoValidate) {
        _formValidationBloc.add(ToggleFormAutoValidation());
      }
    }

    VoidCallback _makeOnPressSubmit(FormValidationState state) {
      return () => _submitForm(state);
    }

    ValueChanged<String> _makeOnNextActionSubmitted(FocusNode fieldFocusNode) {
      return (_) => FocusScope.of(context).requestFocus(fieldFocusNode);
    }

    ValueChanged<String> _makeOnDoneActionSubmitted(FormValidationState state) {
      return (_) {
        _submitForm(state);
        FocusScope.of(context).unfocus();
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        bloc: _registerBloc,
        condition: (prev, cur) {
          return prev.isFailure != cur.isFailure ||
              prev.isSuccess != cur.isSuccess;
        },
        listener: (context, state) {
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          }

          if (state.isFailure) {
            showSnackBarError(
              context: context,
              error: state.error,
            );

            _registerBloc.add(RegisterRequestInit());
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
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
                      child:
                          BlocBuilder<FormValidationBloc, FormValidationState>(
                        bloc: _formValidationBloc,
                        builder: (context, formValidationState) {
                          return FormBuilder(
                            key: _fbKey,
                            autovalidate:
                                formValidationState.isFormAutoValidate,
                            child: Column(
                              children: <Widget>[
                                Flex(
                                  direction: widget.isLandscape(context)
                                      ? Axis.horizontal
                                      : Axis.vertical,
                                  mainAxisSize: widget.isLandscape(context)
                                      ? MainAxisSize.max
                                      : MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      constraints:
                                          _getFormFieldConstraints(context),
                                      child: FormFieldUserName(
                                        controller: _usernameController,
                                        onFiledSubmitted:
                                            _makeOnNextActionSubmitted(
                                          _emailFocusNode,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      constraints:
                                          _getFormFieldConstraints(context),
                                      child: FormFieldEmail(
                                        controller: _emailController,
                                        focusNode: _emailFocusNode,
                                        onFiledSubmitted:
                                            _makeOnNextActionSubmitted(
                                          _password1FocusNode,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Flex(
                                    direction: widget.isLandscape(context)
                                        ? Axis.horizontal
                                        : Axis.vertical,
                                    mainAxisSize: widget.isLandscape(context)
                                        ? MainAxisSize.max
                                        : MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        constraints:
                                            _getFormFieldConstraints(context),
                                        child: FormFieldPassword(
                                          label: 'Password',
                                          controller: _password1Controller,
                                          focusNode: _password1FocusNode,
                                          onFiledSubmitted:
                                              _makeOnNextActionSubmitted(
                                            _password2FocusNode,
                                          ),
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
                                          focusNode: _password2FocusNode,
                                          onFiledSubmitted:
                                              _makeOnDoneActionSubmitted(
                                            formValidationState,
                                          ),
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocBuilder<RegisterBloc, RegisterState>(
                                  bloc: _registerBloc,
                                  builder: (context, registerState) {
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
      ),
    );
  }
}
