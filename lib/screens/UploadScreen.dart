import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadScreen extends StatefulWidget {
  _UploadScreenState createState() => new _UploadScreenState();
}


class _UploadScreenState extends State<UploadScreen> {
  var _image;
  bool _imageTaken= false;

  Future _getPicture() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = image;
      _imageTaken = true;
    });
  }

  _uploadImage() async {
    final StorageReference fireBaseStorageRef = FirebaseStorage.instance.ref().child('myimage.jpg');
    final StorageUploadTask task = fireBaseStorageRef.putFile(this._image);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // padding: EdgeInsets.symmetric(vertical: 100.0),
      body: Center(
        child: (_imageTaken == true) ?
        Container(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Image.file(
                _image,
                scale: 6.0,
                // width: 600.0,
                // height: 240.0,
              ),
              RaisedButton(
                child: Text('Upload'),
                onPressed: _uploadImage,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                child: Text('Retake'),
                onPressed: _getPicture,
              )
            ],
          )
        )
        :
        RaisedButton(
          child: Text('Press the Button to Upload a Set of Notes'),
          onPressed: _getPicture,
        )
       
      ),
      // floatingActionButton: FloatingActionButton(
      //       onPressed: _getPicture,
      //       child: Icon(Icons.camera_alt),
      //     ),
    ); 
  } 
}