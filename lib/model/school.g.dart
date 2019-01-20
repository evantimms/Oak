// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) {
  return School()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..location = json['location'] as String
    ..courseIDs =
        (json['courseIDs'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$SchoolToJson(School instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('location', instance.location);
  writeNotNull('courseIDs', instance.courseIDs);
  return val;
}
