import 'package:Oak/model/note.dart';

class User{
  String _uid;
  String _username;
  String _email;
  int _tokens;

  List<dynamic> _createdNotes;
  List<dynamic> _savedNotes;

  User(
    this._uid,
    this._username,
    this._email,
    this._tokens,
    this._createdNotes,
    this._savedNotes
  );

  String get uid => _uid;
  String get username => _username;
  String get email => _email;
  int get tokens => _tokens;
  List<dynamic> get createdNotes => _createdNotes;
  List<dynamic> get savedNotes => _savedNotes;

  User.map(dynamic obj) {
    this._uid = obj['uid'];
    this._username = obj['username'];
    this._email = obj['email'];
    this._tokens = obj['tokens'];
    this._createdNotes = obj['created_notes'];
    this._savedNotes = obj['saved_notes'];
  }

  User.fromSnapshot(Map<String, dynamic> snapshot) {
    _uid = snapshot['uid'];
    _username = snapshot['username'];
    _email = snapshot['email'];
    _tokens =snapshot['tokens'];
    _createdNotes = snapshot['created_notes'];
    _savedNotes = snapshot['saved_notes'];
  }

  toObject() {
    return {
      'uid':_uid,
      'username':_username,
      'email':_email,
      'tokens':_tokens,
      'created_notes':_createdNotes,
      'saved_notes':_savedNotes,
    };
  }

}