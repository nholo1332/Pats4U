import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
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