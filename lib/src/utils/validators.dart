var emailReg =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

typedef ValidatorFn<T> = T Function(T value);

abstract class Validator {
  static String email(String value) {
    if (value.isEmpty) {
      return 'Email is requared';
    } else if (!RegExp(emailReg).hasMatch(value)) {
      return 'Enter valid email';
    }

    return null;
  }
}
