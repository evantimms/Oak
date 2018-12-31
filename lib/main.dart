import 'package:flutter/material.dart';
import 'screens/MainScreen.dart';
import 'screens/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool _loggedIn = true;



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noted',
      theme: ThemeData(),
      home: (_loggedIn == true) ? MainScreen() : LoginScreen(),
    );
  }
}

