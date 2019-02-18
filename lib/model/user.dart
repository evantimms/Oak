import 'package:flutter_note_app/model/note.dart';

class User{
  String username;
  String name;
  String email;
  int tokens;

  List<Note> createdNotes;
  List<Note> savedNotes;
}