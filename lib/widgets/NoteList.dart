import 'package:flutter/material.dart';
import 'NoteCard.dart';
import '../model/note.dart';

class NoteList extends StatelessWidget {
  List<Note> notes;

  NoteList (notes) {
    this.notes = notes;
  }

  List<NoteCard> _buildNotes(BuildContext context){
    List<NoteCard> cards = [];
    this.notes.forEach((note) {
      cards.add(new NoteCard(note.toObject()));
    });
    return cards;
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
