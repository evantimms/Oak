import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {

  Course();

  String id;

  String name;
  String proffesor;
  String semester; //Likely unecessary with start date and end date

  DateTime startDate;
  DateTime endDate;
  
  List<String> noteIDs;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}