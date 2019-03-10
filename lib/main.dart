import 'package:flutter/material.dart';
import './Root.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oak',
      theme: ThemeData(),
      home: Root()
    );
  }
}

