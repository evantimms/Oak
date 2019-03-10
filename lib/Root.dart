import 'package:flutter/material.dart';
import './model/user.dart';
import 'screens/MainScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/SplashScreen.dart';
import 'auth/Authenticator.dart';

enum AuthStatus {
  UNKNOWN,
  NOT_LOGGED_IN,
  LOGGED_IN
}

final Authenticator auth = new Authenticator();

class Root extends StatefulWidget {
  @override
  _RootState createState() => new _RootState(); 
}

class _RootState extends State<Root> {
  AuthStatus authStatus = AuthStatus.UNKNOWN;
  User current;

  @override 
  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          current = user;
          authStatus = AuthStatus.LOGGED_IN;
        } else {
          current = null;
          authStatus = AuthStatus.NOT_LOGGED_IN;
        }
      });
    }).catchError((e){
      setState(() {
        current = null;
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    });
  }

  Future<void> _signout() {
    auth.signOut().then((_){
      setState(() {
        current = null;
        authStatus = AuthStatus.NOT_LOGGED_IN;
      });
    }).catchError((e){
      print(e);
      setState(() { authStatus =AuthStatus.NOT_LOGGED_IN; });
    });
  }

  Future<void> _signup(String email, String password, String username) {
    auth.signUp(email, password, username).then((newUser){
      setState(() {
        current = newUser;
        authStatus = AuthStatus.LOGGED_IN;
      });
    }).catchError((e){
      setState(() { authStatus =AuthStatus.NOT_LOGGED_IN; });
    });
  }

  Future<void> _login(String email, String password) {
    return auth.signIn(email, password).then((newUser){
      setState(() {
        current = newUser;
        authStatus = AuthStatus.LOGGED_IN;
      });
      return null;
    }).catchError((e){
      setState(() { authStatus =AuthStatus.NOT_LOGGED_IN; });
      return e;
    });
  }

  @override 
  Widget build(BuildContext context) {
    switch(authStatus) {
      case AuthStatus.UNKNOWN:
        return SplashScreen();
        break;
      case AuthStatus.LOGGED_IN:
        return MainScreen(
          currentUser: current,
          signout: _signout
        );
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginScreen(
          login: _login,
          signup: _signup
        );
        break;
      default: 
        return SplashScreen();
    }
  }
}