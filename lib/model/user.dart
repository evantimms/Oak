import 'package:Oak/model/note.dart';
import 'package:firebase_database/firebase_database.dart';

class User{
  String _id;
  String _username;
  String _email;
  int _tokens;

  List<Note> _createdNotes;
  List<Note> _savedNotes;

  User(
    this._id,
    this._username,
    this._email,
    this._tokens,
    this._createdNotes,
    this._savedNotes
  );

  String get id => _id;
  String get username => _username;
  String get email => _email;
  int get tokens => _tokens;
  List<Note> get createdNotes => _createdNotes;
  List<Note> get savedNotes => _savedNotes;

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._username = obj['username'];
    this._email = obj['email'];
    this._tokens = obj['tokens'];
    this._createdNotes = obj['created_notes'];
    this._savedNotes = obj['saved_notes'];
  }

  User.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _username = snapshot.value['username'];
    _email = snapshot.value['email'];
    _tokens =snapshot.value['tokens'];
    _createdNotes = snapshot.value['created_notes'];
    _savedNotes = snapshot.value['saved_notes'];

  }

  toObject() {
    return {
      'id':_id,
      'username':_username,
      'email':_email,
      'tokens':_tokens,
      'createdNotes':_createdNotes,
      'savedNotes':_savedNotes,
    };
  }

}