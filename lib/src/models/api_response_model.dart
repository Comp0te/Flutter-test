import './model.dart';

class LoginResponseModel {
  String token;
  UserModel user;
}

abstract class LoginInput {
  static String email;
  static String password;
}