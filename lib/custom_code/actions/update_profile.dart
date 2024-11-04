// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/custom_code/actions/super_library.dart';

Future updateProfile(
  String displayName,
  String photoUrl,
) async {
  // Add your function code here!
  await UserService.instance.updateProfile(
    displayName: displayName,
    photoUrl: photoUrl,
  );
}
