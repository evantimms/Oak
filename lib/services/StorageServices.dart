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
      final ByteData bytes = await rootBundle.load(filePath);
      final Directory tempDir = Directory.systemTemp;
      final String filename = '${Random().nextInt(10000)}.jpg';
      final File file = File('${tempDir.path}/${filename}');
      file.writeAsBytes(bytes.buffer.asInt8List(), mode: FileMode.write);

      final StorageUploadTask task = fbStorageRef.child(filename).putFile(file);
      final StorageTaskSnapshot snapshot = await task.onComplete.then((snapshot){
        return snapshot;
      })
      .catchError((e){
        print(e);
      });

      final Uri downloadUrl = await snapshot.ref.getDownloadURL();
      imageIds.add(downloadUrl.toString());
    }
    
    var noteObj = note.toObject();
    noteObj.imageIds = imageIds;

    Note updatedNote = new Note.map(noteObj);
    DbServices.updateNoteSetInDB(updatedNote);
  }

  static Future<void> retrieveImageSet(Note note) {

  }
}