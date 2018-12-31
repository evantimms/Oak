import 'package:flutter_note_app/model/note.dart';

class Course {
  String name;
  String proffesor;
  String semester; //Likely unecessary with start date and end date

  DateTime startDate;
  DateTime endDate;
  
  List<Note> notes;
}