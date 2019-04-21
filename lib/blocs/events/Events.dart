import '../../auth/Authenticator.dart';

// Event Types
enum AuthEventType { LOGIN, LOGOUT, SIGNUP }
enum NoteEventType { CREATE, GET }

// Event Classes
class BaseEvent {
  // All event classes need to extend from this one
  Map _options;
  get options => _options;

  BaseEvent(Map options) {
    this._options = options;
  }
}

class AuthEvent extends BaseEvent {
  Authenticator auth = new Authenticator();
  AuthEvent(Map options) : super(options);
}

class NoteEvent extends BaseEvent {

  NoteEvent(Map options) : super(options);
}