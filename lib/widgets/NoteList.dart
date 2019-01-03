import 'package:flutter/material.dart';
import 'NoteCard.dart';

class NoteList extends StatelessWidget {

  List<NoteCard> _buildNotes(BuildContext context){

    return [new NoteCard(), new NoteCard(), new NoteCard(),
    new NoteCard(), new NoteCard(),];
  }

  @override
  Widget build(BuildContext context){
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0/9.0,
      children: _buildNotes(context),
    );
  }

}