import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  //Firebase Auth object
  FirebaseAuth _auth;

  //Default status
  Status _status = Status.Uninitialized;

  Status get status => _status;

  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);

  AuthProvider() {
    //initialise object
    _auth = FirebaseAuth.instance;

    //listener for authentication changes such as user sign in and sign out
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  //Create user object based on the given FirebaseUser
  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }

    return UserModel(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL);
  }

  UserModel currentUser() {
    if (user == null) {
      return null;
    }

    return _userFromFirebase(_auth.currentUser);
  }

  //Method to detect live auth changes such as user sign in and sign out
  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  //Method for new user registration using email and password
  Future<UserModel> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      _status = Status.Registering;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      notifyListeners();
      final GoogleAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //Authenticate against Firebase with Google credentials
      final UserCredential userCredential =
          await _auth.signInWithCredential(googleAuthCredential);

      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  //Method to handle user sign in using email and password
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  //Method to handle user signing out
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
