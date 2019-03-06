import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/note.dart';
import '../model/user.dart';

final dBReference = FirebaseDatabase.instance.reference();
final usersReference  = dBReference.child('users');
final notesReference = dBReference.child('notes');

class ServiceFile {

  Future<void> addNewUserInDB(User user) {
    usersReference.push().set(user.toObject()).then((_){

    }); 
  }

  Future<void> updateCurrentUserInDB(User user) {
    usersReference.child(user.id).set(user.toObject()).then((_) {

    });
  }

  Future<User> readCurrentUserInDB(User user) {

  }

  Future<void> deleteUserInDB(User user) {
    usersReference.child(user.id).remove().then((_) {

    });
  }

  Future<void> addNoteSetInDB(Note note) {

  }

  Future<void> updateNoteSetInDB(Note note) {

  }

  Future<void> readNoteSetInDB(Note note) {

  }

  Future<void> deleteNoteSetInDB(Note note) {

  }
}