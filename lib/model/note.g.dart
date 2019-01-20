// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note()
    ..id = json['id'] as String
    ..createdBy = json['createdBy'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..pdfID = json['pdfID'] as String
    ..upVotes = json['upVotes'] as int
    ..downVotes = json['downVotes'] as int;
}

Map<String, dynamic> _$NoteToJson(Note instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('createdBy', instance.createdBy);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('pdfID', instance.pdfID);
  writeNotNull('upVotes', instance.upVotes);
  writeNotNull('downVotes', instance.downVotes);
  return val;
}
