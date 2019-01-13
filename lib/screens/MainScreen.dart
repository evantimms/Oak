//TODO: Figure out how to simply these imports
import 'package:flutter/material.dart';
import '../screens/NotesScreen.dart';
import '../screens/UploadScreen.dart';
import '../screens/SearchScreen.dart';
import '../screens/SettingsScreen.dart';
import '../screens/TransactionScreen.dart';

class MainScreen extends StatefulWidget{
  final auth;

  MainScreen({this.auth});

  @override
  _MainScreenState createState() => new _MainScreenState(); 
}

class _MainScreenState extends State<MainScreen>  with TickerProviderStateMixin {

  final List<Widget> _children  = [
    UploadScreen(),
    NotesScreen(),
    SearchScreen()
  ];

  int _currentIndex = 1;
  
  // Changes current page 
  void _onTabTapped(int newIndex){
    setState(() {
          _currentIndex = newIndex;
        });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTED"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => SettingsScreen(auth: widget.auth )),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.monetization_on),
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => TransactionScreen()),
              );
            },
          )
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
       onTap: _onTabTapped, // new
       currentIndex: _currentIndex, // new
       items: [
         new BottomNavigationBarItem(
           icon: Icon(Icons.file_upload),
           title: Text('Upload'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.home),
           title: Text('My Notes'),
         ),
         new BottomNavigationBarItem(
           icon: Icon(Icons.search),
           title: Text('Search'),
         )
       ]
      ),
    );
  }
}