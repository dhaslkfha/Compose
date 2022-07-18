// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jsonparse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id'],
  );
  return User(
    json['id'] as String,
    json['isAdult'] as bool? ?? false,
    json['name'] as String,
    json['email'] as String,
    json['my_first_key'] as String,
    Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'my_first_key': instance.myFirstName,
      'isAdult': instance.isAdult,
      'id': instance.id,
      'address': instance.address.toJson(),
    };
