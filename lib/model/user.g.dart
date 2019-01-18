// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..uuid = json['uuid'] as String
    ..tokens = json['tokens'] as int
    ..createdNoteIDs =
        (json['createdNoteIDs'] as List)?.map((e) => e as String)?.toList()
    ..subscribedNoteIDs =
        (json['subscribedNoteIDs'] as List)?.map((e) => e as String)?.toList()
    ..subscribedCourseIDs = (json['subscribedCourseIDs'] as List)
        ?.map((e) => e as String)
        ?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  writeNotNull('name', instance.name);
  writeNotNull('email', instance.email);
  writeNotNull('uuid', instance.uuid);
  writeNotNull('tokens', instance.tokens);
  writeNotNull('createdNoteIDs', instance.createdNoteIDs);
  writeNotNull('subscribedNoteIDs', instance.subscribedNoteIDs);
  writeNotNull('subscribedCourseIDs', instance.subscribedCourseIDs);
  return val;
}
