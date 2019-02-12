import 'package:flutter/material.dart';
import 'NoteCard.dart';
import '../data.dart';

class NoteList extends StatefulWidget {
  String type;

  NoteList (type) {
    this.type = type;
  }

  _NoteListState createState() => _NoteListState(this.type);
}


class _NoteListState extends State<NoteList> {
  var getData;

  _NoteListState (type) {
    if (type == 'saved') {
      getData = _getSavedNotes;
    }else if (type == 'featured') {
      getData = _getFeaturedList;
    }
  }

  Object _getSavedNotes () {
    return [];
  }

  Object _getFeaturedList () {
    return DATA;
  }

  List<NoteCard> _buildNotes(BuildContext context){
    var data = this.getData();
    if (data == []) return <NoteCard>[];
    var toReturn = <NoteCard>[];
    print(data);
    var notes = data;
    notes.forEach((el) {
      print(el);
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