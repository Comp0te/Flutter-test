import 'package:flutter/material.dart';

abstract class ValidationHelper {
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
