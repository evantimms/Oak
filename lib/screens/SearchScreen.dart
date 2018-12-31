import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => new _SearchScreenState(); 
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = new TextEditingController();
  String _searchString = "";

  void _performSearch(String submitted){

  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: <Widget>[
          TextField(
          
            controller: _textEditingController,
            onChanged: (String input){
              _searchString = input;
            },
            onSubmitted: _performSearch,
          ),
          SizedBox(
            height: 300.0,
            child: ListView(),
          )
        ],
      ),
    );
  } 
}