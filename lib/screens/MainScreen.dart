//TODO: Figure out how to simply these imports
import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import '../screens/NotesScreen.dart';
import '../screens/UploadScreen.dart';
import '../screens/SearchScreen.dart';
import '../screens/SettingsScreen.dart';
import '../screens/TransactionScreen.dart';
import '../model/user.dart';

class MainScreen extends StatefulWidget{
  MainScreen({ this.currentUser, this.signout });

  final User currentUser;
  final VoidCallback signout;

  @override
  _MainScreenState createState() => new _MainScreenState(); 
}

class _MainScreenState extends State<MainScreen>  with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  List<Widget> _children  = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));

    _children = [
      NotesScreen(),
      SearchScreen(),
      SettingsScreen(signout: widget.signout)
    ];
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  // Changes current page 
  void _onTabTapped(int newIndex){
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _children[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the camera screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadScreen()));
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.lightBlueAccent,
      ),
      bottomNavigationBar:  BubbleBottomBar(
        opacity: 0.2,
        onTap: _onTabTapped, // new
        currentIndex: _currentIndex, // new
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.deepPurple,
            icon: Icon(Icons.home, color: Colors.black),
            title: Text('Notes'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.search, color: Colors.black,),
            title: Text('Search'),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.settings, color: Colors.black,),
            title: Text('Settings'),
          )
        ]
        ),
    );
  }
}