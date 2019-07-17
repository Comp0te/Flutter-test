import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

import './model.dart';

part 'login.g.dart';

@JsonSerializable()
class LoginInput {
  String email;
  String password;

  LoginInput({@required this.email, @required this.password});

  factory LoginInput.fromJson(Map<String, dynamic> json) => _$LoginInputFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInputToJson(this);
}

@JsonSerializable()
class LoginResponse {
  String token;
  User user;

  LoginResponse(this.token, this.user);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
