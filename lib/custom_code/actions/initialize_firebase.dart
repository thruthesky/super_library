// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:firebase_core/firebase_core.dart';

// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4JBZruWm7i8GI6W5Ge8HjXPN6LxEzZqM',
    appId: '1:109766947030:ios:eae019b92ec00259239977',
    messagingSenderId: '109766947030',
    projectId: 'withcenter-test-4',
    databaseURL: 'https://withcenter-test-4-default-rtdb.firebaseio.com',
    storageBucket: 'withcenter-test-4.appspot.com',
    androidClientId:
        '109766947030-4oi5i0u241r3aefqa7rtpf4ong4ckg12.apps.googleusercontent.com',
    iosClientId:
        '109766947030-d3jjndi0cm5qa021lgk32qfks0e141tg.apps.googleusercontent.com',
    iosBundleId: 'com.withcenter.test4',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVp4ERqSY3dfQctY700eBdcbXmSZRPJEU',
    appId: '1:109766947030:web:adea06b4bee7a666239977',
    messagingSenderId: '109766947030',
    projectId: 'withcenter-test-4',
    authDomain: 'withcenter-test-4.firebaseapp.com',
    databaseURL: 'https://withcenter-test-4-default-rtdb.firebaseio.com',
    storageBucket: 'withcenter-test-4.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDtI3oWwJAvmVC4tF1wbu8OwvTUYx1gxU8',
    appId: '1:109766947030:android:71725a7330089776239977',
    messagingSenderId: '109766947030',
    projectId: 'withcenter-test-4',
    databaseURL: 'https://withcenter-test-4-default-rtdb.firebaseio.com',
    storageBucket: 'withcenter-test-4.appspot.com',
  );
}

Future initializeFirebase() async {
  // Add your function code here!
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
