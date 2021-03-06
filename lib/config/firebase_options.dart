// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDobRgFGG8Emn6iEE1tU-OGfEndHz4XmP4',
    appId: '1:603721193548:web:ed1bde98472cfe29e83ce9',
    messagingSenderId: '603721193548',
    projectId: 'pats4u-88d84',
    authDomain: 'pats4u-88d84.firebaseapp.com',
    storageBucket: 'pats4u-88d84.appspot.com',
    measurementId: 'G-7G6QNGPT09',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdQ6rQHnSaTc__JqMmu-h6HXf-mbCnfUE',
    appId: '1:603721193548:android:7159d722806e17dae83ce9',
    messagingSenderId: '603721193548',
    projectId: 'pats4u-88d84',
    storageBucket: 'pats4u-88d84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8TdY1IRaTFhWB--NFizakzSWt9EiHltU',
    appId: '1:603721193548:ios:6236c28861661010e83ce9',
    messagingSenderId: '603721193548',
    projectId: 'pats4u-88d84',
    storageBucket: 'pats4u-88d84.appspot.com',
    iosClientId:
        '603721193548-v1n59l1grkto8simtp22t04rnu6reurq.apps.googleusercontent.com',
    iosBundleId: 'com.clfbla.pats4u',
  );
}
