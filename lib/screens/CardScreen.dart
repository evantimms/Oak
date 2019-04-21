import 'package:flutter/material.dart';
import 'dart:io';
import '../model/user.dart';
import '../model/note.dart';
import '../auth/Authenticator.dart';
import '../services/StorageServices.dart';
import '../services/DbServices.dart';

final Authenticator auth = new Authenticator();

class CardScreen extends StatefulWidget {
  Note note;
  List<String> imagePaths;
  CardScreen (data) {
    this.note = Note.map(data);
  }
  
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  List<Widget> _previewImageList = [];
  bool  _hasAccess = false;
  int _currentIndex = 0;
  User _current;
  bool _loadingImages = true;
  bool _savingImage = false;

  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(()  {
        _loadingImages = true;
        _previewImageList = [];
        _current = user;
        _hasAccess = _checkUserAccess();
      });
    });
    this._getImages();
  }

  void dispose() {
    this._updateNoteProperties();
    super.dispose();
  }

  _checkUserAccess() {
    bool hasAccess = false;
    _current.savedNotes.forEach((n) {
      if (n.id == widget.note.id) {
        hasAccess =  true;
      }
    });
    return hasAccess;
  }

  _requestAccess() {
    // TODO: Implement transactions, for now just add to saved notes
    setState(() {
      _savingImage = true;
    });
    if (_current != null && widget.note != null) {
      var userObj = _current.toObject();
      userObj['saved_notes'].add(widget.note);
      DbServices.updateCurrentUserInDB(new User.map(userObj)).then((_) {
        setState((){
          _savingImage = false;
        });
      });
    }
  }

  void _getImages() async {
    List<Widget> imageWidgets = [];
    List<File> imagePaths = await StorageServices.retrieveImageSet(widget.note);
    if (imagePaths.length > 0) {
      imageWidgets = List<Widget>.generate(imagePaths.length, (index) {
        return ( 
          Image.asset(
            imagePaths[index].path,
            height: 300,
            width: 400,
            fit: BoxFit.cover,
          )
        );
      });
    }
    setState(() {
      _previewImageList = imageWidgets;
      _loadingImages = false;
    });
  }

  void _ratePos() {
    var noteObj = widget.note.toObject();
    if (noteObj['rating'] != null) {
      noteObj['rating'] += 1;
    }
    widget.note = new Note.map(noteObj);
  }

  void _rateNeg() {
    var noteObj = widget.note.toObject();
    if (noteObj['rating'] != null && noteObj['rating'] > 0) {
      noteObj['rating'] -= 1;
    }
    widget.note = new Note.map(noteObj);
  }

  void _updateNoteProperties() {
    Note note = widget.note;
    DbServices.updateNoteSetInDB(note); // wont currently work
  }

  @override 
  Widget build(BuildContext context){

    Widget loadingIndicator = Center(
      child: CircularProgressIndicator()
    );
    Widget previewImage = (!this._loadingImages) ? Padding(
      padding: EdgeInsets.all(8.0),
      child: Dismissible(
        resizeDuration: null,
        onDismissed: (DismissDirection direction) {
          int indexChange = direction == DismissDirection.endToStart ? 1 : -1;
          if ((_currentIndex == 0 && indexChange == -1) || 
          (_currentIndex == _previewImageList.length - 1 && indexChange == 1)) indexChange = 0;
          setState(() {
            _currentIndex = _currentIndex + indexChange;
          });
        },
        key: ValueKey(this._currentIndex),
        child: this._previewImageList != null && this._previewImageList.length != 0 ? this._previewImageList[_currentIndex] : Container(),
      )
    ) : loadingIndicator;

    Widget descriptionSection = Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              widget.note.title,
              textScaleFactor: 2.0,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                 widget.note.description
                ),
              )  
          )
        ],
      ),
    );
    final noteText = (!_hasAccess) ? 'Unlock these notes' : 'You own these notes';
    Widget viewButton = Expanded(
      child: Align(
        alignment:  Alignment.bottomCenter,
        child:  RaisedButton(
          onPressed: () {
            if (!_hasAccess) {
              this._requestAccess();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.lock_open, color: Colors.white,),
              (!_savingImage) ? Text(noteText, style: TextStyle(color: Colors.white)) : loadingIndicator
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );

    Widget ratingButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: Row(
            children: <Widget>[
              Icon(Icons.thumb_up),
              Text((widget.note.rating != null) ? widget.note.rating.toString() : '0')
            ],
          ),
        ),
        Row(
          children: <Widget>[
            RaisedButton(
              onPressed: _ratePos,
              child: Icon(Icons.thumb_up),
            ),
            RaisedButton(
              onPressed: _rateNeg,
              child: Icon(Icons.thumb_down),
              
            )
          ],
        )
        
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: <Widget>[
          (_hasAccess) ? IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {print('delete note');},
          ) : Container(),
          IconButton(
            icon: Icon(Icons.report),
            onPressed: () {print('report note');},
          )
        ],
      ),
      body: Column(
            children: <Widget>[
              previewImage,
              ratingButtons,
              descriptionSection,
              viewButton
            ],
          )
      );
  }
}