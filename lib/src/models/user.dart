import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int id;
  String username;
  String email;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String avatar;
  String location;
  @JsonKey(name: 'color_scheme')
  String colorScheme;
  String language;

  User(
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
    this.location,
    this.colorScheme,
    this.language,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
