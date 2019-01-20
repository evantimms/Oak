import 'package:flutter/material.dart';
import 'package:flutter_note_app/model/model.dart';
import 'package:flutter_note_app/controllers/database_controller.dart';


class DatabaseTestPage extends StatefulWidget {
  @override
  _DatabaseTestPageState createState() => _DatabaseTestPageState();
}

class _DatabaseTestPageState extends State<DatabaseTestPage> {
  final DatabaseController controller = DatabaseController();
  User _user = User();
  School _school = School();
  Course _course = Course();
  Note _note = Note();


  uploadUser() async {
    _user
    ..email = 'crutkows@ualberta.ca'
    ..name = 'Chase Rutkowski'
    ..username = 'crutkows'
    ..uuid = 'YEPANL14bpPuPaQL3X9iWMEQhJK2';

    await controller.addUser(_user);
    
  }

  uploadSchool() async {
    _school
    ..name = 'University of Alberta'
    ..location = 'Edmonton lol rip';

    String id = await controller.addSchool(_school);
    _school.id = id;
  }

  uploadCourse() async {
    _course
    ..name = 'CMPUT 301'
    ..proffesor = 'Ahbram fucking Hindle'
    ..semester = 'Never';

    String id = await controller.addCourse(_course, _school.id);
    _course.id = id;
  }

  uploadNote() async {
    _note
    ..title = 'Leet CS Notes 420 Blaze It'
    ..createdBy = _user.username
    ..description = 'You read the title';

    String id = await controller.addNote(_note);
    _note.id = id;
  }

  deleteAll() async {
    await controller.deleteNote(_note.id);
    await controller.deleteCourse(_course.id, _school.id);
    await controller.deleteSchool(_school.id);
    controller.deleteUser(_user.uuid);
  }

  getAll() async {
    print((await controller.getUser(_user.uuid)).email);
    print((await controller.getSchool(_school.id)).name);
    print((await controller.getCourse(_course.id, _school.id)).proffesor);
    print((await controller.getNote(_note.id)).title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          OutlineButton(
            child: Text('Upload Test'),
            onPressed: () {
              uploadUser();
              uploadSchool();
              uploadCourse();
              uploadNote();
            },
          ),
          OutlineButton(
            child: Text('Delete Test'),
            onPressed: () {
              deleteAll();
            },
          ),
          OutlineButton(
            child: Text('Retrieval Test'),
            onPressed: () {
              getAll();
            },
          ),
        ],
      ),
    );
  }
}