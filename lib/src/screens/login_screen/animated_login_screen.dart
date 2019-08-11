import 'package:flutter/material.dart';
import 'package:flutter_app/src/screens/screens.dart';

class AnimatedLoginScreen extends StatefulWidget {
  @override
  _AnimatedLoginScreenState createState() => _AnimatedLoginScreenState();
}

class _AnimatedLoginScreenState extends State<AnimatedLoginScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _width;
  Animation<double> _opacity;
  Animation<EdgeInsets> _marginEmail;
  Animation<EdgeInsets> _marginPassword;
  Animation<EdgeInsets> _paddingScreen;
  Animation<Color> _color;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..forward();

    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.5,
          curve: Curves.linear,
        ),
      ),
    );
    _width = Tween<double>(
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
    _marginEmail = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(bottom: 20),
      end: const EdgeInsets.only(bottom: 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.elasticIn,
        ),
      ),
    );
    _marginPassword = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(bottom: 40),
      end: const EdgeInsets.only(bottom: 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.bounceOut,
        ),
      ),
    );
    _paddingScreen = Tween<EdgeInsets>(
      begin: const EdgeInsets.symmetric(horizontal: 0),
      end: const EdgeInsets.symmetric(horizontal: 30),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.decelerate,
        ),
      ),
    );
    _color = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.25,
          1.0,
          curve: Curves.easeIn,
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return LoginScreen(
          color: _color.value,
          heroRegisterWidth: _width.value,
          marginBottomEmail: _marginEmail.value,
          marginBottomPassword: _marginPassword.value,
          paddingHorizontalScreen: _paddingScreen.value,
          submitOpacity: _opacity.value,
        );
      },
    );
  }
}
