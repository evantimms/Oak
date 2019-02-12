import 'package:flutter/material.dart';
import '../screens/CardScreen.dart';


class NoteCard extends StatelessWidget {
  String createdBy;
  String title;
  String description;
  String coursePrefix;
  String courseNumber;
  String school;


  NoteCard (data) {
    this.createdBy = data.createdBy;
    this.title = data.title;
    this.description = data.description;
    this.coursePrefix = data.coursePrefix;
    this.courseNumber = data.courseNumber;
    this.school = data.school;
  }

  void _handleOnTap(BuildContext context){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => new CardScreen()));
  }

  @override
  Widget build(BuildContext context){
    return new InkWell(
      onTap: (){_handleOnTap(context);},
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0/11.0,
              child: Icon(Icons.image),
              
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.title),
                    SizedBox(height: 8.0),
                    Text(this.coursePrefix + this.courseNumber)
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    ); 
    
    
  } 
}
