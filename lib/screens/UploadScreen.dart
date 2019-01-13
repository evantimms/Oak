import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  _UploadScreenState createState() => new _UploadScreenState();
}


class _UploadScreenState extends State<UploadScreen> {
  var _image;

  Future _getPicture() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = image;
    });
    print(_image);
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100.0),
      child:  Center(
        child: Column(
            children: <Widget>[
              Text("To upload a set of notes, press the button below"),
              SizedBox(
                height: 20.0,
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                iconSize: 50.0,
                onPressed: _getPicture
              )
            ],
          )
        )
    ); 
  } 
}