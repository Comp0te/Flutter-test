import 'package:flutter/material.dart';

import 'package:flutter_app/generated/i18n.dart';

abstract class ValidationHelper {
  static FormFieldValidator makeConfirmPasswordValidator({
    @required TextEditingController passwordController,
    @required BuildContext context,
  }) {
    return (dynamic val) {
      if (passwordController.text != val) {
        return S.of(context).errorPasswordsDoNotMatch;
      }

      return null;
    };
  }
}
