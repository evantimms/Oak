import 'package:flutter/material.dart';
import '../screens/CardScreen.dart';
import '../auth/Authenticator.dart';


class NoteCard extends StatelessWidget {
  var data;

  NoteCard (data) {
    this.data = data;
  }

  void _handleOnTap(BuildContext context, Object data){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => new CardScreen(data)));
  }

  @override
  Widget build(BuildContext context){
    return new InkWell(
      onTap: (){_handleOnTap(context, data);},
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
                    Text(this.data['title']),
                    SizedBox(height: 8.0),
                    Text(this.data['course_prefix'] + this.data['course_number'])
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
