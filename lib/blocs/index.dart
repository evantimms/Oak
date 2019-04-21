import 'package:bloc/bloc.dart';
import './states/States.dart';
import './events/Events.dart';
import '../model/user.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  AuthState get initialState => AuthState.initial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    switch (event.options.currentEvent) {
      case AuthEventType.LOGIN:
        String email = event.options['email'];
        String password = event.options['password'];
        User user = await event.auth.signIn(email, password);
        yield currentState..user = user;
        break;
      case AuthEventType.SIGNUP:
        String email = event.options['email'];
        String password = event.options['password'];
        User user = await event.auth.signUp(email, password);
        yield currentState..user = user;
        break;
      case AuthEventType.LOGOUT:
        await event.auth.signOut();
        yield currentState..user = null;
        break;
    }
  }

  // Handlers
  void onLogin(String email, String password) {
    // Do something with the email and password
    var options = {
      'email': email,
      'password': password,
      'currentEvent': AuthEventType.LOGIN
    };
    dispatch(new AuthEvent(options));
  }

  void onSignup(String email, String password) {
    var options = {
      'email': email,
      'password': password,
      'currentEvent': AuthEventType.SIGNUP
    };
    dispatch(new AuthEvent(options));
  }

  void onLogout() {
    var options = {
      'currentEvent': AuthEventType.LOGOUT
    };
    dispatch(new AuthEvent(options));
  }

}

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  @override
  get initialState => NoteState.initial();

  @override
  Stream<NoteState> mapEventToState(event) {
    switch(event.options.currentEvent) {
      case NoteEventType.CREATE:
        break;
      case NoteEventType.GET:
        break;
    }
  }

}