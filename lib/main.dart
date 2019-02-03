import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/MainScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/SplashScreen.dart';
import 'auth/authentication.dart';

Auth authenticator = new Auth();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  List _getFakeDataRequest () {
    
    return [];
  }

  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new SplashScreen();
        } else {
          if (snapshot.hasData) {
            return new MainScreen(auth: authenticator);
          }
          return new LoginScreen(auth: authenticator);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noted',
      theme: ThemeData(),
      home: _handleCurrentScreen()
    );
  }
}

