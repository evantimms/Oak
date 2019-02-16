import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'EditAndConfirmUploadScreen.dart';

List<CameraDescription> cameras;

class UploadScreen extends StatefulWidget {
  _UploadScreenState createState() => new _UploadScreenState();
}


class _UploadScreenState extends State<UploadScreen> {
  CameraController camController;
  bool isEditMode;
  List<String> imagePaths;
  String currentImagePath;

  Future<void> _getAvailableCameras() async {
    cameras = await availableCameras();
    camController = CameraController(cameras[0], ResolutionPreset.medium);
    camController.initialize().then((_) {
      if (!mounted) return;
      else setState((){
        isEditMode = false;
        currentImagePath = '';
        imagePaths = [];
      });
    });
  }

  @override 
  void initState() {
    super.initState();
    _getAvailableCameras();
  }

  @override
  void dispose() {
    camController?.dispose();
    super.dispose();
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!camController.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    
    if (camController.value.isTakingPicture) {
      return null;
    }

    // get picture
    try {
      await camController.takePicture(filePath);
    } on CameraException catch (e) {
      print(e);
      return null;
    }
    return filePath;
  }

  // Controllers ========================
  void _onPictureCapture() {
    _takePicture().then((String filePath){
      if (filePath != null) {
        setState(() {
          isEditMode = true; 
          currentImagePath = filePath;
        });
      }
    });
    
  }

  void _onPictureRetake() {
    imagePaths.remove(currentImagePath);
    this.setState((){
      isEditMode = false;
      currentImagePath = '';
    });
  }

  void _onPictureSave() {
    if (currentImagePath != null && currentImagePath.length > 0) {
      imagePaths.add(currentImagePath);
      setState(() {
       currentImagePath = '';
       isEditMode = false; 
      });
    }
    
  }

  void _onUserFinish() {
    if (currentImagePath != null && currentImagePath.length > 0) {
      imagePaths.add(currentImagePath);
    }

    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EditAndConfirmUploadScreen(imagePaths: imagePaths)),
    );
    setState(() {
      imagePaths = [];
      currentImagePath = '';
      isEditMode = false;
    });
    // Navigate to confirmation page
    
  }
  // ======================================
  Widget _getCameraOrPreviewDisplay() {
    print(currentImagePath);
    print(isEditMode);
    if (camController == null || !camController.value.isInitialized) {
      return Text(
        'No Camera Found',
        style: TextStyle(
          fontSize: 24
        ),
      );
    } else if (isEditMode && currentImagePath.length > 0) {
      return AspectRatio(
        aspectRatio: camController.value.aspectRatio,
        child: Image.file(File(currentImagePath))
      );
    } else if (!isEditMode && camController != null && camController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: camController.value.aspectRatio,
        child: CameraPreview(camController),
      );
    } else {
      // Return a loading indicator
      return Center(child: CircularProgressIndicator());
    }
  }

  List<Widget> _getEditControls() {
    return <Widget>[
      RaisedButton(
        onPressed: _onPictureRetake,
        child: Text('Retake'),
      ),
      RaisedButton(
        onPressed: _onPictureSave,
        child: Text('Take Next'),
      ),
      RaisedButton(
        onPressed: _onUserFinish,
        child: Text('Done'),
      ),
    ];
  }

  Widget _captureControlWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: (!isEditMode) ? <Widget>[
        IconButton(
          icon: Icon(Icons.camera_alt),
          color: Colors.blueAccent,
          onPressed: (camController != null &&
          camController.value.isInitialized) ?
          _onPictureCapture : null,
        )
      ] : _getEditControls()
    );
  }


  @override
  Widget build(BuildContext context){
    if (camController == null || !camController.value.isInitialized) {
      return Container();
    }
    else {
      return Scaffold(
      // padding: EdgeInsets.symmetric(vertical: 100.0),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _getCameraOrPreviewDisplay(),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    color: camController != null && camController.value.isRecordingVideo
                        ? Colors.redAccent
                        : Colors.grey,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            _captureControlWidget()
          ],
        )
      );
    }
  } 
}