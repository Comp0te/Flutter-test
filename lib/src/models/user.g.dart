// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'] as int,
      json['username'] as String,
      json['email'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['avatar'] as String,
      json['location'] as int,
      json['color_scheme'] as String,
      json['language'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'location': instance.location,
      'color_scheme': instance.colorScheme,
      'language': instance.language
    };
