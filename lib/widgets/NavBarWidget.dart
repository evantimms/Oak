import 'package:flutter/material.dart';

class NavBarWidget extends StatefulWidget{

  _NavBarWidgetState createState()=> new _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int newIndex){
    setState(() {
          _currentIndex = newIndex;
        });
  }
  
  @override 
  Widget build(BuildContext context){
    return BottomNavigationBar(
       onTap: _onTabTapped, // new
       currentIndex: _currentIndex, // new
       items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.file_upload),
           title: Text('Featured'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text('Home'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.settings),
           title: Text('Search'),
         )
       ]
    );
  }
}