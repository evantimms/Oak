import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  var data;

  CardScreen (data) {
    this.data = data;
  }
  
  @override
  _CardScreenState createState() => _CardScreenState(data);
}

class _CardScreenState extends State<CardScreen> {
  var data;

  _CardScreenState (data) {
    this.data = data;
  }

  final List<Widget> _previewImageList = <Widget>[
    Image.asset(
      'images/note1.jpg',
      height: 300,
      width: 400,
      fit: BoxFit.cover,
    ),
    Image.asset(
      'images/note2.jpg',
      height: 300,
      width: 400,
      fit: BoxFit.cover,
    ),
  ];

  int _currentIndex = 0;

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
              data['title'],
              textScaleFactor: 2.0,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(data['dateCreated'].toString()),
          ),
          Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                 data['description']
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
          onPressed: () {},
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
        title: Text('ECE 311'),
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