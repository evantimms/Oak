import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/MainScreen.dart';
import 'screens/LoginScreen.dart';
import 'screens/SplashScreen.dart';
import 'auth/Authenticator.dart';

Authenticator auth = new Authenticator();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  Widget _handleCurrentScreen() {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new SplashScreen();
        } else {
          if (snapshot.hasData) {
            auth.getCurrentUser();
            return new MainScreen();
          }
          return new LoginScreen();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oak',
      theme: ThemeData(),
      home: _handleCurrentScreen()
    );
  }
}

