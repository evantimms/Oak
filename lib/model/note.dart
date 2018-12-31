import 'package:flutter_note_app/model/user.dart';

class Note {
  User createdBy;
  String title;
  String description;

  String pdfID; // TODO: figure out how pds are saved in class
  
  int upVotes;
  int downVotes;

  double getRating() {
    // TODO: create algorithm for calculating rating
    return upVotes / downVotes;
  }
}