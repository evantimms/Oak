import 'package:flutter/material.dart';
import '../widgets/NoteList.dart';
import '../services/DbServices.dart';
import '../auth/Authenticator.dart';
import '../model/note.dart';
import '../model/user.dart';
import 'dart:async';
import 'dart:io';

enum CurrentScreen {
  SAVED,
  FEATURED
}

final Authenticator auth = new Authenticator();

class NotesScreen extends StatefulWidget {

  @override
  _NotesScreenState createState()=> new _NotesScreenState(); 
}

class _NotesScreenState extends State<NotesScreen> with TickerProviderStateMixin {
  CurrentScreen currentScreen = CurrentScreen.FEATURED;
  User current;
  List<Note> featuredNotes;
  List<Note> savedNotes;

  @override
  void initState() {

    super.initState();
    auth.getCurrentUser().then((user) {
      DbServices.getAllNotesInDB().then((notes) {
        setState(() {
          current = user;
          featuredNotes = notes;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            TabBar(
              labelColor: Colors.black,
              labelPadding: EdgeInsets.symmetric(horizontal: 25.0),
              isScrollable: true,
              tabs: <Widget>[
                Tab(
                  text: "Saved Notes",
                ),
                Tab(
                  text: "Featured Notes",
                )
              ],
            ),
            Expanded(
              // height: 300.0,
              child: TabBarView(
                children: <Widget>[
                  NoteList(savedNotes),
                  NoteList(featuredNotes)
                ],
              ),
            )
          ],
        ),
      ),
    
    );
      
  }
}
