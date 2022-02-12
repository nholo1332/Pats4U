import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<UserCredential> login(String email, String password) {
    return FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<UserCredential> register(String email, String password) {
    return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() {
    return FirebaseAuth.instance.signOut();
  }

  static Future<String> getToken({bool force = false}) {
    var completer = Completer<String>();

    if ( FirebaseAuth.instance.currentUser != null ) {
      FirebaseAuth.instance.currentUser!.getIdToken(force).then((value) {
        completer.complete(value);
      }).catchError((error) {
        completer.completeError(error);
      });
    } else {
      completer.completeError('No user');
    }

    return completer.future;
  }

}