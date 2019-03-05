import 'package:Oak/model/note.dart';

class User{
  String username;
  String name;
  String email;
  int tokens;

  List<Note> createdNotes;
  List<Note> savedNotes;
}