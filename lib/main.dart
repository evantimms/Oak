import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/MainScreen.dart';
import './Root.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final themeData = ThemeData(
    // Define the default Brightness and Colors
    brightness: Brightness.light,
    primaryColor: Colors.lightBlue,
    accentColor: Colors.lightBlueAccent,
    
    // Define the default Font Family
    fontFamily: 'Montserrat',
    
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      title: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: Colors.white24),
      body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oak',
      theme: themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => Root(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MainScreen()
      }
    );
  }
}

