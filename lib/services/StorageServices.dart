import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_storage/firebase_storage.dart';
import './DbServices.dart';
import '../model/note.dart';

StorageReference fbStorageRef = FirebaseStorage.instance.ref();

class StorageServices {

  static Future<void> uploadImageSet(List<String> filePaths, Note note) async {
    List<String> imageIds = [];

    for (String filePath in filePaths) {
      try {
        final ByteData bytes = await rootBundle.load(filePath);
        final Directory tempDir = Directory.systemTemp;
        final String filename = '${Random().nextInt(10000)}.jpg';
        final File file = File('${tempDir.path}/${filename}');
        file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

        final StorageUploadTask task = fbStorageRef.child(filename).putFile(file);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        imageIds.add(downloadUrl);
      } catch (e) {
        throw e;
      }
    }
    var noteObj = note.toObject();
    noteObj['image_ids'] = imageIds;
    Note updatedNote = new Note.map(noteObj);
    await DbServices.updateNoteSetInDB(updatedNote);
  }

  static Future<List> retrieveImageSet(Note note) async {
    List<File> imageList = [];
    final List<String> downloadUrls = note.imageIds;
    final RegExp regex = RegExp('[^?/]*\.(jpg)');

    for (String url in downloadUrls) {
      try {
        final String filename = regex.stringMatch(url);
        final Directory tempDir = Directory.systemTemp;
        final File file = File('${tempDir.path}/${filename}');
      
        final StorageFileDownloadTask task = fbStorageRef.child(filename).writeToFile(file);
        await task.future;
        imageList.add(file);
      } catch(e) {
        throw e;
      }
    }
    return imageList;
  }
}