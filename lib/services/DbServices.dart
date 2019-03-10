import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/note.dart';
import '../model/user.dart';

final dBReference = FirebaseDatabase.instance.reference();
final usersReference  = dBReference.child('users');
final notesReference = dBReference.child('notes');

class DbServices {

  static Future<User> getUserFromFBUser(FirebaseUser fbUser) {
    String email = fbUser.email;
    usersReference.orderByChild('email').equalTo(email).once().then((data){
      return User.fromSnapshot(data);
    }).catchError((onError){
      print(onError);
    });
  }

  // CRUD using normal user model
  static Future<void> addNewUserInDB(User user) {
    usersReference.push().set(user.toObject()).then((_) {
      return User;
    }); 
  }

  static Future<void> updateCurrentUserInDB(User user) {
    usersReference.child(user.id).set(user.toObject());
  }

  static Future<void> readCurrentUserInDB(User user) {

  }

  static Future<void> deleteUserInDB(User user) {
    usersReference.child(user.id).remove();
  }

  static Future<void> addNoteSetInDB(Note note) {

  }

  static Future<void> updateNoteSetInDB(Note note) {

  }

  static Future<void> readNoteSetInDB(Note note) {

  }

  static Future<void> deleteNoteSetInDB(Note note) {

  }
}