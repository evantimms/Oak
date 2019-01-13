import 'package:flutter/material.dart';

class CardScreen extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    Widget previewImage = Image.asset(
      'images/stock.jpg',
      height: 260.0,
      width: 500,
      fit: BoxFit.cover,
    );

    Widget descriptionSection = Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              'Title',
              textScaleFactor: 2.0,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                'Description'
              )  
          )
        ],
      ),
    );
    
    

    Widget viewButton = Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.lock),
                Text('Unlock')
              ],
            )
          ],
        ),
      ),
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text('Note Title'),
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
              SizedBox(height: 100, width: 200),
              viewButton
            ],
          )
      );
  }
}