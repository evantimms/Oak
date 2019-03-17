import 'package:flutter/material.dart';
import '../model/user.dart';
import '../auth/Authenticator.dart';

final Authenticator auth = new Authenticator();

class CardScreen extends StatefulWidget {
  var data;
  List<String> imagePaths;
  CardScreen (data) {
    this.data = data;
    imagePaths = data.imageIds;
  }
  
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  List<Widget> _previewImageList;
  bool  hasAccess;
  int _currentIndex;
  User current;

  void initState() {
    super.initState();
    setState(() async {
      _previewImageList = this._getImages();
      _currentIndex = 0;
      current = await auth.getCurrentUser();
      hasAccess = _checkUserAccess();
    });
    
  }

  _checkUserAccess() {
    bool hasAccess = false;
    current.savedNotes.forEach((n) {
      if (n.id == widget.data.id) {
        hasAccess =  true;
      }
    });
    return hasAccess;
  }

  _requestAccess() {
    // TODO: Implement
  }

  List<Widget> _getImages() {
    return List.generate(widget.imagePaths.length, (index) {
      return ( 
        Image.asset(
          widget.imagePaths[index],
          height: 300,
          width: 400,
          fit: BoxFit.cover,
        )
      );
    });
  }

  @override 
  Widget build(BuildContext context){


    Widget previewImage = Padding(
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
        child: this._previewImageList[_currentIndex],
      )
    );

    Widget descriptionSection = Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              widget.data['title'],
              textScaleFactor: 2.0,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(widget.data['dateCreated'].toString()),
          ),
          Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                 widget.data['description']
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
        title: Text(widget.data.title),
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