import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:flutter_app/src/mixins/mixins.dart';
import 'package:flutter_app/src/constants/constants.dart';
import 'package:flutter_app/src/widgets/widgets.dart';
import 'package:flutter_app/src/blocs/blocs.dart';

// TODO: think about https://pub.dev/packages/reflectable
enum LoginFormData { email, password }

class LoginScreen extends StatefulWidget with OrientationMixin, ThemeMixin {
  final double heroRegisterWidth;
  final double submitOpacity;
  final EdgeInsets marginBottomInput;
  final EdgeInsets marginBottomInputWrapper;
  final EdgeInsets paddingHorizontalScreen;
  final Color color;

  const LoginScreen({
    Key key,
    this.heroRegisterWidth = 150,
    this.submitOpacity = 1,
    this.marginBottomInput = const EdgeInsets.only(bottom: 0),
    this.marginBottomInputWrapper = const EdgeInsets.only(bottom: 20),
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

  @override
  Widget build(BuildContext context) {
    void _toRegistrationScreen() {
      Navigator.of(context).pushNamed(AuthRouteNames.register);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).loginGreetings,
          style: widget.getPrimaryTextTheme(context).headline,
        ),
        backgroundColor: widget.color,
        centerTitle: true,
//        backgroundColor: widget.color,
      ),
      body: AuthMultiLoginBlocListener(
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
                              _buildFormInputs(context, validationEnabled),
                              _buildSubmitButtons(context, validationEnabled),
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

  Widget _buildFormInputs(BuildContext context, bool validationEnabled) {
    ValueChanged<String> _makeOnNextActionSubmitted(FocusNode fieldFocusNode) {
      return (_) => FocusScope.of(context).requestFocus(fieldFocusNode);
    }

    ValueChanged<String> _makeOnDoneActionSubmitted(bool validationEnabled) {
      return (_) {
        _submitForm(context, validationEnabled);
        FocusScope.of(context).unfocus();
      };
    }

    return Container(
      margin: widget.marginBottomInputWrapper,
      child: Flex(
        direction:
            widget.isLandscape(context) ? Axis.horizontal : Axis.vertical,
        mainAxisSize:
            widget.isLandscape(context) ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            constraints: widget.getMaxWidthConstraints(context, 0.4),
            margin: widget.marginBottomInput,
            child: FormFieldEmail(
              controller: _emailController,
              attribute: describeEnum(LoginFormData.email),
              onFiledSubmitted: _makeOnNextActionSubmitted(
                _passwordFocusNode,
              ),
            ),
          ),
          Container(
            constraints: widget.getMaxWidthConstraints(context, 0.4),
            margin: widget.marginBottomInput,
            child: FormFieldPassword(
              controller: _passwordController,
              attribute: describeEnum(LoginFormData.password),
              label: S.of(context).password,
              focusNode: _passwordFocusNode,
              onFiledSubmitted: _makeOnDoneActionSubmitted(
                validationEnabled,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButtons(BuildContext context, bool validationEnabled) {
    VoidCallback _makeOnPressSubmit(bool validationEnabled) {
      return () => _submitForm(context, validationEnabled);
    }

    void _onPressGoogleLogin() {
      BlocProvider.of<GoogleLoginBloc>(context).add(GoogleLoginRequest());
    }

    void _onPressFacebookLogin() {
      BlocProvider.of<FacebookLoginBloc>(context)
          .add(FacebookLoginRequest());
    }

    return Flex(
      direction: widget.isPortrait(context) ? Axis.vertical : Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: widget.getMaxWidthConstraints(context, 0.25),
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, loginState) {
              return Opacity(
                opacity: widget.submitOpacity,
                child: SubmitButton(
                  isLoading: loginState is LoginLoading,
                  title: S.of(context).loginEmail,
                  color: widget.color,
                  onPress: _makeOnPressSubmit(
                    validationEnabled,
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          constraints: widget.getMaxWidthConstraints(context, 0.25),
          child: BlocBuilder<GoogleLoginBloc, GoogleLoginState>(
            builder: (context, googleLoginState) {
              return Opacity(
                opacity: widget.submitOpacity,
                child: SubmitButton(
                  isLoading: googleLoginState is GoogleLoginLoading,
                  title: S.of(context).loginWith('Google'),
                  color: widget.color,
                  onPress: _onPressGoogleLogin,
                ),
              );
            },
          ),
        ),
        Container(
          constraints: widget.getMaxWidthConstraints(context, 0.25),
          child: BlocBuilder<FacebookLoginBloc, FacebookLoginState>(
            builder: (context, facebookLoginState) {
              return Opacity(
                opacity: widget.submitOpacity,
                child: SubmitButton(
                  isLoading: facebookLoginState is FacebookLoginLoading,
                  title: S.of(context).loginWith('Facebook'),
                  color: widget.color,
                  onPress: _onPressFacebookLogin,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _submitForm(BuildContext context, bool validationEnabled) {
    if (_fbKey.currentState.validate()) {
      BlocProvider.of<LoginBloc>(context).add(LoginRequest(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    } else if (!validationEnabled) {
      _validationEnabledBloc.add(ToggleBoolValue());
    }
  }
}
