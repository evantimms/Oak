import 'package:flutter_note_app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note {

  Note();

  String id;

  String createdBy;
  String title;
  String description;

  String pdfID; // TODO: figure out how pds are saved in class
  
  int upVotes;
  int downVotes;

  setCreatetBy(User user) {
    createdBy = user.username;
  }

  double getRating() {
    // TODO: create algorithm for calculating rating
    return upVotes / downVotes;
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}