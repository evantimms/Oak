import 'package:flutter/material.dart';
import 'screens/MainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noted',
      theme: ThemeData(),
      home: MainScreen(),
    );
  }
}

