import 'dart:async';
import './StorageServices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/note.dart';
import '../model/user.dart';
import '../auth/Authenticator.dart';


final dBReference = Firestore.instance;
final usersReference  = dBReference.collection('users');
final notesReference = dBReference.collection('notes');
final auth = Authenticator();

class DbServices {

  // Auth services
  static Future<User> getUserFromFBUser(FirebaseUser fbUser) async {
    String uid = fbUser.uid;
    QuerySnapshot query = await usersReference.where('uid', isEqualTo: uid).getDocuments();
    if (query.documents.length != 0) {
      var data = query.documents[0].data;
      // get notes from DB for user
      var formattedData = await _convertRefsToNotes(data);
      return User.map(formattedData);
    } else {
      print('user with this account does not exist');
      return null;
    }
  }

  static Future<User> createUserFromFBUser(FirebaseUser fbUser) async {
    User newUser = _buildDbUser(fbUser);
    await addNewUserInDB(newUser);
    return getUserFromFBUser(fbUser);
  }

  // User CRUD using normal user model
  static Future<void> addNewUserInDB(User user) async {
    await usersReference.document(user.uid).setData(user.toObject());
    _transact();
  }

  static Future<void> updateCurrentUserInDB(User user) async {
    await usersReference.document(user.uid).updateData(user.toObject());
    _transact();
  }

  static Future<void> readCurrentUserInDB(User user) async {
    String uid = user.uid;
    var query = await usersReference.document(uid).get();
    if (query.data != null) {
      var data = query.data;
      var formattedData = await _convertRefsToNotes(data);
      _transact();
      return User.map(formattedData);
    }
  }

  static void deleteUserInDB(User user) {
    String uid = user.uid;
    usersReference.document(uid).delete();
    _transact();
  }

  // Note CRUD
  static Future<void> addNoteSetInDB(Note note, List<String> filePaths) async {
    // Passed a incomplete note, needs list of documentReferences
    // 1. create the note
    // 2. call the storage file to upload the notes, this will update the note
    // 3. Update the user with the new note 
    
    await notesReference.document(note.id).setData(note.toObject());
    await StorageServices.uploadImageSet(filePaths, note);
    User current = await auth.getCurrentUser();

    DocumentReference noteRef = _getNoteRef(note.id);
    current = _convertNotesToRefs(current);
    print(current.toObject());
    current.savedNotes.add(noteRef);
    print(current.toObject());
    await updateCurrentUserInDB(current);
    _transact();
  }

  static Future<void> updateNoteSetInDB(Note note) async {
    await notesReference.document(note.id).updateData(note.toObject());
    _transact();
  }

  static Future<void> readNoteSetInDB(Note note) {

  }

  static Future<void> deleteNoteSetInDB(Note note) {
    notesReference.document(note.id).delete();
    _transact();
  }

  static _transact() {

  }

  static _buildDbUser(FirebaseUser fbUser) {
    return new User(
      fbUser.uid,
      fbUser.displayName,
      fbUser.email,
      0,
      [],
      [] 
    );
  }

  static _convertRefsToNotes(Map<String, dynamic> data) async {
    List<dynamic> createdNotesRefs = data['created_notes'];
    List<dynamic> savedNotesRefs = data['saved_notes'];
    List<Note> createdNotes = [];
    List<Note> savedNotes = [];
    for (DocumentReference noteref in createdNotesRefs) {
      DocumentSnapshot response = await noteref.get();
      var note = response.data;
      createdNotes.add(new Note.map(note));
    }

    for (DocumentReference noteref in savedNotesRefs) {
      DocumentSnapshot response = await noteref.get();
      var note = response.data;
      savedNotes.add(new Note.map(note));
    }
    data['created_notes'] =createdNotes;
    data['saved_notes'] =savedNotes;
    return data;
  }

  static _convertNotesToRefs(User user) {
    List<Note> createdNotes = user.createdNotes;
    List<Note> savedNotes = user.savedNotes;

    List<DocumentReference> createNotesRefs = [];
    List<DocumentReference> savedNotesRefs = [];

    for (Note note in createdNotes) {
      DocumentReference ref = _getNoteRef(note.id);
      createNotesRefs.add(ref);
    }

    for (Note note in savedNotes) {
      DocumentReference ref =_getNoteRef(note.id);
      savedNotesRefs.add(ref);
    }

    var userObj = user.toObject();
    userObj['saved_notes'] = savedNotesRefs;
    userObj['created_notes'] = createNotesRefs;
    return new User.map(userObj);
  }

  static DocumentReference _getNoteRef(id) {
    return notesReference.document(id);
  }
}