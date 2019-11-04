import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/helpers/validation_helper.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegisterScreen extends StatefulWidget with OrientationMixin {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fbKey = GlobalKey<FormBuilderState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();
  final _validationEnabledBloc = BoolValueBloc();
  final _emailFocusNode = FocusNode();
  final _password1FocusNode = FocusNode();
  final _password2FocusNode = FocusNode();

  BoxConstraints _getFormFieldConstraints(BuildContext context) =>
      widget.isLandscape(context)
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.40)
          : const BoxConstraints();

  @override
  Widget build(BuildContext context) {
    void _submitForm(bool validationEnabled) {
      if (_fbKey.currentState.validate()) {
        BlocProvider.of<RegisterBloc>(context).add(RegisterRequest(
          username: _usernameController.text,
          email: _emailController.text,
          password1: _password1Controller.text,
          password2: _password2Controller.text,
        ));
      } else if (!validationEnabled) {
        _validationEnabledBloc.add(ToggleBoolValue());
      }
    }

    VoidCallback _makeOnPressSubmit(bool validationEnabled) {
      return () => _submitForm(validationEnabled);
    }

    ValueChanged<String> _makeOnNextActionSubmitted(FocusNode fieldFocusNode) {
      return (_) => FocusScope.of(context).requestFocus(fieldFocusNode);
    }

    ValueChanged<String> _makeOnDoneActionSubmitted(bool validationEnabled) {
      return (_) {
        _submitForm(validationEnabled);
        FocusScope.of(context).unfocus();
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
      ),
      body: AuthBlocListener<RegisterBloc, RegisterState>(
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
                      child: BlocBuilder<BoolValueBloc, bool>(
                        bloc: _validationEnabledBloc,
                        builder: (context, validationEnabled) {
                          return FormBuilder(
                            key: _fbKey,
                            autovalidate: validationEnabled,
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
                                            ValidationHelper
                                                .makeConfirmPasswordValidator(
                                              passwordController:
                                                  _password1Controller,
                                            )
                                          ],
                                          focusNode: _password2FocusNode,
                                          onFiledSubmitted:
                                              _makeOnDoneActionSubmitted(
                                            validationEnabled,
                                          ),
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocBuilder<RegisterBloc, RegisterState>(
                                  builder: (context, registerState) {
                                    return SubmitButton(
                                      isLoading: registerState.isLoading,
                                      title: 'Submit',
                                      onPress: _makeOnPressSubmit(
                                        validationEnabled,
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
