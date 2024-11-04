// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';
import 'super_library.dart';

Future likeExist(
  String path,
  Future Function(bool value) callback,
) async {
  if (currentUserUid == null) {
    return callback(false);
  }

  final event = await LikeService.instance.likeRef(path).once();
  if (event.snapshot.exists) {
    callback(true);
    return;
  }
  callback(false);
}
