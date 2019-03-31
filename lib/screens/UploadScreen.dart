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
  CameraController _controller;
  bool _isEditMode;
  List<String> _imagePaths;
  String _currentImagePath;

  Future<void> _getAvailableCameras() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) return;
      else setState((){
        _isEditMode = false;
        _currentImagePath = '';
        _imagePaths = [];
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
    _controller?.dispose();
    super.dispose();
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';
    
    if (_controller.value.isTakingPicture) {
      return null;
    }

    // get picture
    try {
      await _controller.takePicture(filePath);
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
          _isEditMode = true; 
          _currentImagePath = filePath;
        });
      }
    });
    
  }

  void _onPictureRetake() {
    _imagePaths.remove(_currentImagePath);
    this.setState((){
      _isEditMode = false;
      _currentImagePath = '';
    });
  }

  void _onPictureSave() {
    if (_currentImagePath != null && _currentImagePath.length > 0) {
      _imagePaths.add(_currentImagePath);
      setState(() {
       _currentImagePath = '';
       _isEditMode = false; 
      });
    }
    
  }

  void _onUserFinish() async {
    if (_currentImagePath != null && _currentImagePath.length > 0) {
      _imagePaths.add(_currentImagePath);
    }
    await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EditAndConfirmUploadScreen(_imagePaths)),
    );
    setState(() {
      _imagePaths = [];
      _currentImagePath = '';
      _isEditMode = false;
    });
    // Navigate to confirmation page
    
  }
  // ======================================
  Widget _getCameraOrPreviewDisplay() {
    if (_controller == null || !_controller.value.isInitialized) {
      return Text(
        'No Camera Found',
        style: TextStyle(
          fontSize: 24
        ),
      );
    } else if (_isEditMode && _currentImagePath.length > 0) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Image.file(File(_currentImagePath))
      );
    } else if (!_isEditMode && _controller != null && _controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
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
      children: (!_isEditMode) ? <Widget>[
        IconButton(
          icon: Icon(Icons.camera_alt),
          color: Colors.blueAccent,
          onPressed: (_controller != null &&
          _controller.value.isInitialized) ?
          _onPictureCapture : null,
        )
      ] : _getEditControls()
    );
  }


  @override
  Widget build(BuildContext context){
    if (_controller == null || !_controller.value.isInitialized) {
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
                    color: _controller != null && _controller.value.isRecordingVideo
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