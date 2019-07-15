typedef ValidatorFn<T> = T Function(T value);

abstract class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static bool isEmpty(String value) => value.isEmpty;
  static bool isEmailValid(String email) => _emailRegExp.hasMatch(email);
  static bool isPasswordValid(String password) =>
      _passwordRegExp.hasMatch(password);

  static String email(String email) {
    if (isEmpty(email)) {
      return 'Email is requared';
    } else if (!isEmailValid(email)) {
      return 'Enter valid email';
    }

    return null;
  }

  static String password(String password) {
    if (isEmpty(password)) {
      return 'Password is requared';
    } else if (isPasswordValid(password)) {
      return 'Password must contain 8 characters, at least'
          'one capital letter and 1 digit';
    }

    return null;
  }
}
