import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User{

  User();

  String username;
  String name;
  String email;
  String uuid;
  int tokens;

  List<String> createdNoteIDs;
  List<String> subscribedNoteIDs;
  List<String> subscribedCourseIDs;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}