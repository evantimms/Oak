import 'package:flutter/material.dart';
import '../widgets/NavBarWidget.dart';
class MainScreen extends StatefulWidget{

  @override
  _MainScreenState createState() => new _MainScreenState(); 
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTED"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){},
          ),
        ],
      ),
      bottomNavigationBar: NavBarWidget(),
    );
  }
}