// This will be an api for creating, reading, updating, and deleting users
// Going to integrate firebase on this.

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthApi {
  final FirebaseAuth _firebaseAuth;

  AuthApi({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;


  //  This should run at start of app
  Future<bool> isSignedIn() async {
    final _currentUser = await  _firebaseAuth.currentUser();
    return (_currentUser != null);
  }

  Future<FirebaseUser> getUser() async {
    final _currentUser = await  _firebaseAuth.currentUser();
    return (_currentUser);
  }

  Future<FirebaseUser> createNewUser(String email, String password) async {
    final String _email = email;
    final String _password = password;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return await FirebaseAuth.instance.currentUser();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


  Future<void> loginExistingUser(String email, String password) async {
    final String _email = email;
    final String _password = password;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);
          return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<void> updateExistingUserEmail(String newEmail, String password) async {
    String _password = password;
    String _newEmail = newEmail;
    FirebaseUser _user = await _firebaseAuth.currentUser();

    try {
      await _user
          .reauthenticateWithCredential(EmailAuthProvider.getCredential(
              email: _user.email, password: _password))
          .then((onValue) {
        _user.updateEmail(_newEmail);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> deleteExistingUser() async {
    // this will delete an existing user
  }

  Future<void> logOutExistingUser() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    // Implement google signin
  }

}
