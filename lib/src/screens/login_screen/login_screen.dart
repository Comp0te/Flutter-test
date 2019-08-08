import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/servises/snackbar.dart';
import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

class LoginScreen extends StatefulWidget {
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
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FormValidationBloc _formValidationBloc = FormValidationBloc();

  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    void _toRegistrationScreen() {
      Navigator.of(context).pushNamed(AuthRouteNames.register);
    }

    VoidCallback _getOnPressSubmit(FormValidationState state) {
      return () {
        if (_fbKey.currentState.validate()) {
          _loginBloc.dispatch(LoginRequest(
            email: _emailController.text,
            password: _passwordController.text,
          ));
        } else if (!state.isFormAutoValidate) {
          _formValidationBloc.dispatch(ToggleFormAutoValidation());
        }
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: widget.color,
      ),
      body: BlocListener(
        bloc: _loginBloc,
        condition: (LoginState prev, LoginState cur) {
          return !prev.isFailure && prev.isFailure != cur.isFailure ||
              prev.isSuccess != cur.isSuccess;
        },
        listener: (BuildContext context, LoginState state) {
          if (state.isSuccess) {
            BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
          }

          if (state.isFailure) {
            SnackBarService.showError(
              context: context,
              error: state.error,
            );
            _loginBloc.dispatch(LoginRequestInit());
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: SingleChildScrollView(
              padding: widget.paddingHorizontalScreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BlocBuilder(
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
                            Container(
                              margin: widget.marginBottomEmail,
                              child: FormFieldEmail(
                                controller: _emailController,
                              ),
                            ),
                            Container(
                              margin: widget.marginBottomPassword,
                              child: FormFieldPassword(
                                controller: _passwordController,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 40, top: 20),
                              child: BlocBuilder(
                                bloc: _loginBloc,
                                builder: (
                                  BuildContext context,
                                  LoginState loginState,
                                ) {
                                  return Opacity(
                                    opacity: widget.submitOpacity,
                                    child: SubmitButton(
                                      isLoading: loginState.isLoading,
                                      title: 'Submit',
                                      color: widget.color,
                                      onPress: _getOnPressSubmit(
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
    );
  }
}