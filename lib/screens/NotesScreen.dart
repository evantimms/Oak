import 'package:flutter/material.dart';
import '../widgets/NoteList.dart';
import '../services/DbServices.dart';
import '../auth/Authenticator.dart';
import '../model/note.dart';
import '../model/user.dart';


final Authenticator auth = new Authenticator();

class NotesScreen extends StatefulWidget {

  @override
  _NotesScreenState createState()=> new _NotesScreenState(); 
}

class _NotesScreenState extends State<NotesScreen> with TickerProviderStateMixin {
  User current;
  List<Note> featuredNotes;
  List<Note> savedNotes;
  bool _loading;

  @override
  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      DbServices.getAllNotesInDB().then((notes) {
        setState(() {
          current = user;
          featuredNotes = notes;
          savedNotes  = user.savedNotes;
          _loading = false;
        });
      });
    });
    setState((){
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context){
    final loadingIcon = Center(
      child: CircularProgressIndicator(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Container(
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
                    text: "My Notes",
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
                    (_loading) ? loadingIcon : NoteList(savedNotes),
                    (_loading) ? loadingIcon : NoteList(featuredNotes)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
