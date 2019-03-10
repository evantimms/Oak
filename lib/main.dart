import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/MainScreen.dart';
import './Root.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oak',
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => Root(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainScreen()
      }
    );
  }
}

