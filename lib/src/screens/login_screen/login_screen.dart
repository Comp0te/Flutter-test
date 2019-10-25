import 'package:flutter/material.dart';
import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/routes/auth.dart';
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
    with TickerProviderStateMixin, SnackBarMixin {
  final _fbKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formValidationBloc = FormValidationBloc();
  final _passwordFocusNode = FocusNode();

  BoxConstraints _getFormFieldConstraints(BuildContext context) =>
      widget.isLandscape(context)
          ? BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.40)
          : const BoxConstraints();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    void _toRegistrationScreen() {
      Navigator.of(context).pushNamed(AuthRouteNames.register);
    }

    void _submitForm(FormValidationState state) {
      if (_fbKey.currentState.validate()) {
        _loginBloc.add(LoginRequest(
          email: _emailController.text,
          password: _passwordController.text,
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
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: widget.color,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
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
            _loginBloc.add(LoginRequestInit());
          }
        },
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
                    BlocBuilder<FormValidationBloc, FormValidationState>(
                      bloc: _formValidationBloc,
                      builder: (context, formValidationState) {
                        return FormBuilder(
                          key: _fbKey,
                          autovalidate: formValidationState.isFormAutoValidate,
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
                                        formValidationState,
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
                                  bloc: _loginBloc,
                                  builder: (context, loginState) {
                                    return Opacity(
                                      opacity: widget.submitOpacity,
                                      child: SubmitButton(
                                        isLoading: loginState.isLoading,
                                        title: 'Submit',
                                        color: widget.color,
                                        onPress: _makeOnPressSubmit(
                                          formValidationState,
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
