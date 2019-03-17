import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../model/note.dart';
import '../services/DbServices.dart';
import 'package:uuid/uuid.dart';

final uuid = new Uuid();

class EditAndConfirmUploadScreen extends StatefulWidget {
  List<String> _imagePaths;
  EditAndConfirmUploadScreen(_imagePaths) {
    this._imagePaths =_imagePaths;
  }

  _EditAndConfirmUploadScreenState createState() => new _EditAndConfirmUploadScreenState(_imagePaths);

}

class _EditAndConfirmUploadScreenState extends State<EditAndConfirmUploadScreen> {
  List<String> _imagePaths;
  List<Widget> _imageList;
  final _formKey = GlobalKey<FormState>();
  bool _formIsUploadConfirm = false;
  bool _formIsExitConfirm = false;
  int _currentIndex;
  Map _data = { 'id':uuid.v1() };

  _EditAndConfirmUploadScreenState(imagePaths) {
    this._imagePaths = imagePaths;
    this._currentIndex = 0;
  } 

  void _onUploadConfirm(BuildContext context) {
    // 1. Fetch and format data from Form
    // 2. Get Image files
    // 3. Upload to server
    _formKey.currentState.save();
    Note newNote = new Note.map(_data);
    DbServices.addNoteSetInDB(newNote, _imagePaths);
    Navigator.popUntil(context, ModalRoute.withName('/home'));

  }

  List<Widget> _buildImageList() {
    return List<GestureDetector>.generate(_imagePaths.length, (index){
      String currentImagePath = _imagePaths[index];
      return GestureDetector(
        onTap: (){print('tapped image' + currentImagePath);},
        child: Image.file(File(currentImagePath))
      );
    });
  }


  Future<void> _showModalConfirm(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        if (_formIsUploadConfirm) {
          return AlertDialog(
            title: Text('Do you want to upload these notes?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: (){
                  Navigator.of(context).pop();
                  _onUploadConfirm(context);
                },
              ),
              FlatButton(
                child: Text('Go Back'),
                onPressed: (){
                  setState(() {_formIsUploadConfirm = false;});
                  Navigator.of(context).pop();
                },
              )
            ],
          ); 
        } else if (_formIsExitConfirm) {
          return AlertDialog(
            title: Text('Do you want to discard this '),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Go Back'),
                onPressed: (){
                  setState(() {_formIsExitConfirm = false;});
                  Navigator.of(context).pop();
                },
              )
            ],
          ); 
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    this._imageList = _buildImageList();

    Widget noteList = Padding(
      padding: const EdgeInsets.all(16.0),
      child:  Dismissible(
        resizeDuration: null,
        onDismissed: (DismissDirection direction) {
          int indexChange = direction == DismissDirection.endToStart ? 1 : -1;
          if ((_currentIndex == 0 && indexChange == -1) || 
          (_currentIndex == _imageList.length - 1 && indexChange == 1)) indexChange = 0;
          setState(() {
            _currentIndex = _currentIndex + indexChange;
          });
        },
        key: ValueKey(_currentIndex),
        child: _imageList[_currentIndex],
      )
    );


    Widget noteForm = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter A Title';
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Title'
            ),
            onSaved: (value) => _data['title'] = value
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child:  TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter A Course Prefix';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Course Prefix'
                  ),
                  onSaved: (value) => _data['course_prefix'] = value
                ),
              ),
              Flexible(
                child:  TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter A Course Number';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Course Number'
                  ),
                  onSaved: (value) => _data['course_number'] = value
                ),
              )
            ],
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter A Description';
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Description'
            ),
            onSaved: (value) => _data['description'] = value
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter a School';
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'School'
            ),
            onSaved: (value) => _data['school'] = value,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              RaisedButton(
                onPressed: (){
                  setState(() {
                    _formIsExitConfirm = true;
                  });
                  _showModalConfirm(context);
                },
                child: Text('Discard Set'),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                    _formIsUploadConfirm = true;
                    });
                    _showModalConfirm(context);
                  }      
                },
                child: Text('Upload Set'),
              )
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView(
        children: <Widget>[
          noteList,
          noteForm
        ],
      ),
    );
  }
}