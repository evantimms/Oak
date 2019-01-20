// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..proffesor = json['proffesor'] as String
    ..semester = json['semester'] as String
    ..startDate = json['startDate'] == null
        ? null
        : DateTime.parse(json['startDate'] as String)
    ..endDate = json['endDate'] == null
        ? null
        : DateTime.parse(json['endDate'] as String)
    ..noteIDs = (json['noteIDs'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$CourseToJson(Course instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('proffesor', instance.proffesor);
  writeNotNull('semester', instance.semester);
  writeNotNull('startDate', instance.startDate?.toIso8601String());
  writeNotNull('endDate', instance.endDate?.toIso8601String());
  writeNotNull('noteIDs', instance.noteIDs);
  return val;
}
