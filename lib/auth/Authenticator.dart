import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/DbServices.dart';
import '../model/user.dart';

// TODO: This needs to be refactored to be useful
// Base class that is useful if we ever need to switch implementations
abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password, String username);
  Future<String> getCurrentUser();
  Future<void> signOut();
}

class Authenticator extends BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email:email, password: password);
    return user.uid;
  }

  Future<String> signUp(String email, String password, String username) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    print(user);
    return user.uid;
  }

  Future<bool> isLoggedIn() async {
    return _firebaseAuth.currentUser() != null;
  }

  Future<void> signOut(){
    return _firebaseAuth.signOut();
  }
}