// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

/// Return the user's uid if the user is logged in.
///
/// Why:
/// To get the currently login user's uid, since the Firebase is not supported in Library,
Future<String?> loginUserUid() async {
  // Add your function code here!
  return FirebaseAuth.instance.currentUser?.uid;
}
