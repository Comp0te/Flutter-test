import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/widgets/form_field_email.dart';
import 'package:flutter_app/src/widgets/form_field_password.dart';
import 'package:flutter_app/src/widgets/hero_register.dart';
import 'package:flutter_app/src/widgets/submit_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/servises/snackbar.dart';
import 'package:flutter_app/src/utils/constants.dart';
import 'package:flutter_app/src/blocks/blocks.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FormValidationBloc _formValidationBloc = FormValidationBloc();
  AnimationController _animationController;
  Animation<double> width;
  Animation<double> opacity;
  Animation<EdgeInsets> marginEmail;
  Animation<EdgeInsets> marginPassword;
  Animation<Color> color;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();

    opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.500,
          curve: Curves.linear,
        ),
      ),
    );
    width = Tween<double>(
      begin: 50.0,
      end: 150.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.125,
          0.625,
          curve: Curves.ease,
        ),
      ),
    );
    marginEmail = Tween<EdgeInsets>(
      begin: EdgeInsets.only(bottom: 20),
      end: EdgeInsets.only(bottom: 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.50,
          curve: Curves.elasticIn,
        ),
      ),
    );
    marginPassword = Tween<EdgeInsets>(
      begin: EdgeInsets.only(bottom: 40),
      end: EdgeInsets.only(bottom: 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.500,
          1.00,
          curve: Curves.bounceOut,
        ),
      ),
    );
    color = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.25,
          1.00,
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget child) {
            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30),
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
                                margin: marginEmail.value,
                                child: FormFieldEmail(
                                  controller: _emailController,
                                ),
                              ),
                              Container(
                                margin: marginPassword.value,
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
                                      opacity: opacity.value,
                                      child: SubmitButton(
                                        isLoading: loginState.isLoading,
                                        title: 'Submit',
                                        color: color.value,
                                        onPress: _getOnPressSubmit(
                                          formValidationState,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              HeroRegister(
                                width: width.value,
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
            );
          },
        ),
      ),
    );
  }
}
