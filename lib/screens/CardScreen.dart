import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/note.dart';
import '../auth/Authenticator.dart';
import '../services/StorageServices.dart';

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

  void initState() {
    super.initState();
    auth.getCurrentUser().then((user) {
      setState(()  {
        _loadingImages = true;
        _previewImageList = this._getImages();
        _current = user;
        _hasAccess = _checkUserAccess();
      });
    });
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
    // TODO: Implement
  }

  List<Widget> _getImages(){
    StorageServices.retrieveImageSet(widget.note).then((imagePaths) {
      return List.generate(imagePaths.length, (index) {
        print(imagePaths[index]);
        return ( 
          Image.asset(
            imagePaths[index].path,
            height: 300,
            width: 400,
            fit: BoxFit.cover,
          )
        );
      });
    })
    .then((_) {
      print('Done retrieving images');
      setState(() {
        _loadingImages = false;
      });
    })
    .catchError((e) {
      print('error retreiving images');
      print(e);
    });
    return null;
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
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Date Created:'),
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

    Widget viewButton = Expanded(
      child: Align(
        alignment:  Alignment.bottomCenter,
        child:  RaisedButton(
          onPressed: () {
            this._requestAccess();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.lock_open, color: Colors.white,),
              Text('Unlock These Notes', style: TextStyle(color: Colors.white))
            ],
          ),
          color: Colors.blue,
        ),
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.report),
            onPressed: (){},
          )
        ],
      ),
      body: Column(
            children: <Widget>[
              previewImage,
              descriptionSection,
              viewButton
            ],
          )
      );
  }
}