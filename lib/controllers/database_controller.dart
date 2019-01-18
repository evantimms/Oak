//import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_note_app/model/model.dart';

// Controller for handling all interaction with database
// TODO: Will likley need to split into many controllers
class DatabaseController {
  // Names of collections in the cloud firestore database
  static final String _userCollection = 'users';
  static final String _schoolCollection = 'schools';
  static final String _courseCollection = 'courses';
  static final String _noteCollection = 'notes';

  final Firestore firestore = Firestore.instance;

  // --- User functions ---
  Future<void> addUser(User user) async {
    final DocumentReference docReference = firestore.collection(_userCollection).document(user.uuid);
    await docReference.setData(user.toJson());
  }

  Future<User> getUser(String uuid) async {
    final DocumentReference docReference = firestore.collection(_userCollection).document(uuid);

    User user = User.fromJson((await docReference.get()).data);
    return user;
  }




  // --- School functions ---
  Future<void> addSchool(School school) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document();

    school.id = docReference.documentID;
    await docReference.setData(school.toJson());
  }

  Future<void> updateSchool(School school) async {
    assert(school.id != null); // Check school is in database

    final DocumentReference docReference = firestore.collection(_schoolCollection).document(school.id);
    await docReference.setData(school.toJson());
  }

  Future<School> getSchool(String id) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(id);

    School school = School.fromJson((await docReference.get()).data);
    return school;
  }

  Future<void> deleteSchool(String id) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(id);
    await docReference.delete();
  }




  // --- Course Functions ---
  Future<void> addCourse(Course course, String schoolId) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(schoolId).collection(_courseCollection).document();

    course.id = docReference.documentID;
    await docReference.setData(course.toJson());
  }

  Future<void> updateCourse(Course course, String schoolId) async {
    assert(course.id != null);
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(schoolId).collection(_courseCollection).document(course.id);

    await docReference.setData(course.toJson());
  }

  Future<Course> getCourse(String courseId, String schoolId) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(schoolId).collection(_courseCollection).document(courseId);

    Course course = Course.fromJson((await docReference.get()).data);
    return course;
  }

  Future<void> deleteCourse(String courseId, String schoolId) async {
    final DocumentReference docReference = firestore.collection(_schoolCollection).document(schoolId).collection(_courseCollection).document(courseId);
    await docReference.delete();
  }




  // --- Note Functions ---
  Future<void> addNote(Note note) async {
    final DocumentReference docReference = firestore.collection(_noteCollection).document();

    note.id = docReference.documentID;
    await docReference.setData(note.toJson());
  }

  Future<void> updateNote(Note note) async {
    assert(note.id != null);
    final DocumentReference docReference = firestore.collection(_noteCollection).document(note.id);

    await docReference.setData(note.toJson());
  }

  Future<Note> getNote(String id) async {
    final DocumentReference docReference = firestore.collection(_noteCollection).document(id);

    Note note = Note.fromJson((await docReference.get()).data);
    return note;
  }

  Future<void> deleteNote(String id) async {
    final DocumentReference docReference = firestore.collection(_noteCollection).document(id);
    await docReference.delete();
  }
}