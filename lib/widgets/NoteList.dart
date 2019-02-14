import 'package:flutter/material.dart';
import 'NoteCard.dart';
import '../data.dart';

class NoteList extends StatelessWidget {
  String type;

  NoteList (type) {
    this.type = type;
  }

  List _getSavedNotes () {
    return [];
  }

  List _getFeaturedList () {
    return notes;
  }

  List<NoteCard> _buildNotes(BuildContext context){

    var data = (type == 'featured') ? this._getFeaturedList() : this._getSavedNotes();
    
    if (data == []) return <NoteCard>[];
    var toReturn = <NoteCard>[];

    data.forEach((el) {
      toReturn.add(
        NoteCard(el)
      );
    });
    return toReturn;
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
