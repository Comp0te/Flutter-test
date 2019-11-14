import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/src/blocs/blocs.dart';
import 'package:flutter_app/src/helpers/validation_helper.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/widgets/widgets.dart';

enum RegisterFormData { username, email, password1, password2 }

class RegisterScreen extends StatefulWidget with OrientationMixin, ThemeMixin {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).registration,
          style: widget.getPrimaryTextTheme(context).headline,
        ),
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
                                _buildUserNameAndEmailInputs(context),
                                _buildPasswordsInputs(
                                  context,
                                  validationEnabled,
                                ),
                                _buildSubmitButton(context, validationEnabled)
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

  Widget _buildUserNameAndEmailInputs(BuildContext context) {
    return Flex(
      direction: widget.isLandscape(context) ? Axis.horizontal : Axis.vertical,
      mainAxisSize:
          widget.isLandscape(context) ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          constraints: _getFormFieldConstraints(context),
          child: FormFieldUserName(
            attribute: describeEnum(RegisterFormData.username),
            controller: _usernameController,
            onFiledSubmitted: _makeOnNextActionSubmitted(
              context,
              _emailFocusNode,
            ),
          ),
        ),
        Container(
          constraints: _getFormFieldConstraints(context),
          child: FormFieldEmail(
            controller: _emailController,
            attribute: describeEnum(RegisterFormData.email),
            focusNode: _emailFocusNode,
            onFiledSubmitted: _makeOnNextActionSubmitted(
              context,
              _password1FocusNode,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordsInputs(BuildContext context, bool validationEnabled) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Flex(
        direction:
            widget.isLandscape(context) ? Axis.horizontal : Axis.vertical,
        mainAxisSize:
            widget.isLandscape(context) ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            constraints: _getFormFieldConstraints(context),
            child: FormFieldPassword(
              label: S.of(context).password,
              attribute: describeEnum(RegisterFormData.email),
              controller: _password1Controller,
              focusNode: _password1FocusNode,
              onFiledSubmitted: _makeOnNextActionSubmitted(
                context,
                _password2FocusNode,
              ),
            ),
          ),
          Container(
            constraints: _getFormFieldConstraints(context),
            child: FormFieldPassword(
              label: S.of(context).confirmPassword,
              attribute: describeEnum(RegisterFormData.password2),
              controller: _password2Controller,
              validatorsList: [
                ValidationHelper.makeConfirmPasswordValidator(
                  passwordController: _password1Controller,
                  context: context,
                )
              ],
              focusNode: _password2FocusNode,
              onFiledSubmitted: _makeOnDoneActionSubmitted(
                context,
                validationEnabled,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool validationEnabled) {
    print(widget.getTheme(context).textTheme.headline);
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, registerState) {
        return SubmitButton(
          isLoading: registerState is RegisterLoading,
          title: S.of(context).register,
          color: widget.getTheme(context).primaryColor,
          onPress: _makeOnPressSubmit(context, validationEnabled),
        );
      },
    );
  }

  void _submitForm(BuildContext context, bool validationEnabled) {
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

  ValueChanged<String> _makeOnNextActionSubmitted(
    BuildContext context,
    FocusNode fieldFocusNode,
  ) {
    return (_) => FocusScope.of(context).requestFocus(fieldFocusNode);
  }

  ValueChanged<String> _makeOnDoneActionSubmitted(
    BuildContext context,
    bool validationEnabled,
  ) {
    return (_) {
      _submitForm(context, validationEnabled);
      FocusScope.of(context).unfocus();
    };
  }

  VoidCallback _makeOnPressSubmit(
    BuildContext context,
    bool validationEnabled,
  ) {
    return () => _submitForm(context, validationEnabled);
  }
}
