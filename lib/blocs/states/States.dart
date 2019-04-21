import '../../model/user.dart';
import '../../model/note.dart';

class AuthState {
  User user;
  AuthState._();

  factory AuthState.initial() {
    return AuthState._()..user = null;
  }
}

class NoteState {
  List<Note> notes;

  NoteState._();

  factory NoteState.initial() {
    return NoteState._()..notes = null;
  }
}