import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

import '../model.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginInput {
  String email;
  String password;

  LoginInput({@required this.email, @required this.password});

  factory LoginInput.fromJson(Map<String, dynamic> json) =>
      _$LoginInputFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInputToJson(this);
}

@JsonSerializable()
class Token {
  final String token;

  const Token(this.token);

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}

@JsonSerializable()
class AuthResponse extends Token {
  final User user;

  const AuthResponse(String token, this.user) : super(token);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class RegisterInput {
  String username;
  String email;
  String password1;
  String password2;

  RegisterInput({
    this.username,
    @required this.email,
    @required this.password1,
    @required this.password2,
  });

  factory RegisterInput.fromJson(Map<String, dynamic> json) =>
      _$RegisterInputFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterInputToJson(this);
}
