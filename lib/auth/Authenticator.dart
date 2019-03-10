import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/DbServices.dart';
import '../model/user.dart';


// TODO: This needs to be refactored to be useful
// Base class that is useful if we ever need to switch implementations
abstract class BaseAuth {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String username);
  Future<User> getCurrentUser();
  Future<void> signOut();
}

class Authenticator extends BaseAuth {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signIn(String email, String password) async {
    FirebaseUser fbUser = await _firebaseAuth.signInWithEmailAndPassword(email:email, password: password);
    return await DbServices.getUserFromFBUser(fbUser);
  }

  Future<User> signUp(String email, String password, String username) async {
    FirebaseUser fbUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return await DbServices.getUserFromFBUser(fbUser);
  }

  Future<User> getCurrentUser() async {
    FirebaseUser fbUser = await _firebaseAuth.currentUser();
    return await DbServices.getUserFromFBUser(fbUser);
  }

  Future<bool> isLoggedIn() async {
    return await _firebaseAuth.currentUser() != null;
  }

  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}