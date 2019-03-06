import 'package:Oak/model/user.dart';
import 'package:firebase_database/firebase_database.dart';

class Note {
  String _id;
  String _title;
  String _description;
  String _coursePrefix;
  String _courseNumber;
  String _school;
  
  Note(
    this._id,
    this._title, 
    this._description, 
    this._courseNumber, 
    this._coursePrefix, 
    this._school
  );

  String get id => _id;
  String get title => _title;
  String get description => _description;
  String get coursePrefix => _coursePrefix;
  String get courseNumber => _courseNumber;
  String get school => _school;

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._courseNumber = obj['course_number'];
    this._coursePrefix = obj['course_prefix'];
    this._school = obj['school'];
  }

  Note.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _description = snapshot.value['description'];
    _courseNumber = snapshot.value['course_number'];
    _coursePrefix = snapshot.value['course_prefix'];
    _school = snapshot.value['school'];
  }


}