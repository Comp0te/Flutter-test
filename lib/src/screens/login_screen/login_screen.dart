import 'package:flutter/material.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class LoginScreen extends StatefulWidget with OrientationMixin {
  final double heroRegisterWidth;
  final double submitOpacity;
  final EdgeInsets marginBottomEmail;
  final EdgeInsets marginBottomPassword;
  final EdgeInsets paddingHorizontalScreen;
  final Color color;

  const LoginScreen({
    Key key,
    this.heroRegisterWidth = 150,
    this.submitOpacity = 1,
    this.marginBottomEmail = const EdgeInsets.only(bottom: 0),
    this.marginBottomPassword = const EdgeInsets.only(bottom: 0),
    this.paddingHorizontalScreen = const EdgeInsets.symmetric(horizontal: 30),
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _fbKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _validationEnabledBloc = BoolValueBloc();
  final _passwordFocusNode = FocusNode();

  BoxConstraints _getFormFieldConstraints(BuildContext context) =>
      widget.isLandscape(context)
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.40)
          : const BoxConstraints();

  @override
  Widget build(BuildContext context) {
    void _toRegistrationScreen() {
      Navigator.of(context).pushNamed(AuthRouteNames.register);
    }

    void _submitForm(bool validationEnabled) {
      if (_fbKey.currentState.validate()) {
        BlocProvider.of<LoginBloc>(context).add(LoginRequest(
          email: _emailController.text,
          password: _passwordController.text,
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
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: widget.color,
      ),
      body: AuthBlocListener<LoginBloc, LoginState>(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: widget.paddingHorizontalScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocBuilder<BoolValueBloc, bool>(
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
                                    margin: widget.marginBottomEmail,
                                    child: FormFieldEmail(
                                      controller: _emailController,
                                      onFiledSubmitted:
                                          _makeOnNextActionSubmitted(
                                        _passwordFocusNode,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    constraints:
                                        _getFormFieldConstraints(context),
                                    margin: widget.marginBottomPassword,
                                    child: FormFieldPassword(
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      onFiledSubmitted:
                                          _makeOnDoneActionSubmitted(
                                        validationEnabled,
                                      ),
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(bottom: 40, top: 20),
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, loginState) {
                                    return Opacity(
                                      opacity: widget.submitOpacity,
                                      child: SubmitButton(
                                        isLoading: loginState.isLoading,
                                        title: 'Submit',
                                        color: widget.color,
                                        onPress: _makeOnPressSubmit(
                                          validationEnabled,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              HeroRegister(
                                width: widget.heroRegisterWidth,
                                onTap: _toRegistrationScreen,
                              ),
                            ],
                          ),
                        );
                      },
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
