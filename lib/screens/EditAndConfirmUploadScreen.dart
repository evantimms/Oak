import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditAndConfirmUploadScreen extends StatefulWidget {
  final imagePaths;
  EditAndConfirmUploadScreen({this.imagePaths});
  _EditAndConfirmUploadScreenState createState() => new _EditAndConfirmUploadScreenState(imagePaths: imagePaths);

}

class _EditAndConfirmUploadScreenState extends State<EditAndConfirmUploadScreen> {
  List<String> imagePaths;
  final _formKey = GlobalKey<FormState>();
  bool _formSubmitted = false;

  _EditAndConfirmUploadScreenState({this.imagePaths}); 

  Widget _buildPictures() {
    return Container();
  }

  void _handleUpload() {

  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildPictures(),
          ),
          Form(
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
                    labelText: 'Please Enter A Title'
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter A Course Prefix';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Please Enter A Course Prefix'
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter A Course Number';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Please Enter A Course Number'
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter A Description';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Please Enter A Description'
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'School?';
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Please Enter School'
                  ),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){},
                      child: Text('Retake Set'),
                    ),
                    RaisedButton(
                      onPressed: _handleUpload,
                      child: Text('Upload Set'),
                    )
                  ],
                ),
                (_formSubmitted == true) ?
                AlertDialog(
                  title: Text('Are you sure you want to logout?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Yes'),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text('Go Back'),
                      onPressed: (){
                        setState(() {_formSubmitted = false;});
                      },
                    )
                  ],
                ) 
                :
                Container()
              ],
            ),
          )
          
        ],
      ),
    );
  }
}