import 'package:flutter/material.dart';

abstract class Validators {
  static FormFieldValidator makeConfirmPasswordValidator({
    @required TextEditingController passwordController,
  }) {
    return (dynamic val) {
      if (passwordController.text != val) {
        return "Password don't match";
      }

      return null;
    };
  }
}
