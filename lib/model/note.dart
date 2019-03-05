import 'package:Oak/model/user.dart';

class Note {
  User createdBy;
  String title;
  String description;
  String coursePrefix;
  String courseNumber;
  String pdfID; // TODO: figure out how pds are saved in class
}