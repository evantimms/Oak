import 'package:flutter/material.dart';
import '../model/note.dart';
import '../services/DbServices.dart';
import '../widgets/NoteList.dart';

final searchOptions = <String>[ 'School', 'Course', 'Title' ];
const MAX_RESULTS = 200;
const MAX_FILTERS = 5;

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => new _SearchScreenState(); 
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = new TextEditingController();
  String _searchKey;
  String _error = '';
  String _dropDownValue = searchOptions[0];
  bool _loadingRes = false;
  Map<int, String> _filters = {};
  List<Note> _notes = [];

  void _performSearch(String searchKey){
    setState(() {
      _searchKey = '';
      _loadingRes = true;
      _error = '';
      _filters[_filters.keys.length] = searchKey;
      _notes = [];
    });
    DbServices.getNotes(MAX_RESULTS, _filters, _dropDownValue).then((notes) {
      print('got notes:');
      print(notes);
      if (notes != null && notes.length > 0) {
        setState(() {
          _loadingRes = false;
          _notes = notes;
        });
      } else {
        setState(() {
          _loadingRes = false;
          _error = 'No Notes Found.';
        });
      }
    });
  }

  void handleTimeout() {
    setState(() {
      _loadingRes = false;
      _error = 'Failed to get notes. There may be a problem with the server.';
    });
  }

  @override
  Widget build(BuildContext context){
    final searchIcon = Expanded(
      child: Center(
        child: (_loadingRes && _error == '') ? CircularProgressIndicator() : Text(_error),
      ),
    );
    final filterOptions = Column(
        children: (_filters.keys.length > 0) ? List.generate(_filters.keys.length, (i) {
          return new RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_filters[i]),
                Icon(Icons.delete)
              ],
            ),
            onPressed: () {
              setState(() {
                _filters.remove(i);
                if (_filters.keys.length == 0) {
                  _notes = [];
                }
              });
            },
          );
        }) : [Container()],
    );

    final searchQueryWidget = Row(
      children: <Widget>[
        DropdownButton<String>(
          value: _dropDownValue,
          onChanged: (String newValue) {
            setState(() {
              _dropDownValue = newValue;
            });
          },
          items: searchOptions
            .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            })
            .toList(),
        ),
        Expanded(
          child: TextField(
            controller: _textEditingController,
            onChanged: (searchKey) {
              setState(() {
                _searchKey = searchKey;
              });
            },
            onSubmitted: (String searchKey) {
              _textEditingController.clear();
              if (searchKey != ''){
                _performSearch(searchKey);
              }
            },
          )
        ),
      ],
    );

    return Container(
      child: Column(
        children: <Widget>[
          filterOptions,
          searchQueryWidget,
          (_loadingRes) ? searchIcon : Expanded( child: NoteList(_notes) )
        ],
      ),
    );
  } 
}