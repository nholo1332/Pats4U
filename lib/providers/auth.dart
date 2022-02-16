import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:pats4u/providers/events_cache_manager.dart';
import 'package:pats4u/providers/user_cache_manager.dart';

class Auth {
  // Get current user (or return null if no user is signed in)
  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  // Handle login
  static Future<UserCredential> login(String email, String password) {
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  // Handle registration
  static Future<UserCredential> register(String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // Sign out of current account and clear events and user cache
  static Future<void> signOut() {
    return EventsCacheManager().emptyCache().then((_) {
      UserCacheManager.resetUser();
      return UserCacheManager().emptyCache();
    }).then((_) {
      return FirebaseAuth.instance.signOut();
    });
  }

  /* Gets the current (or create a new) Firebase auth token to be sent to the
  server for authenticated requests. The token is decoded on the server */
  static Future<String> getToken({bool force = false}) {
    var completer = Completer<String>();

    if (FirebaseAuth.instance.currentUser != null) {
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
