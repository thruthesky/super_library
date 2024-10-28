// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

Future deleteData(
  BuildContext context,
  String key,
  Future Function()? onDelete,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!

  try {
    await Data.deleteByKey(key);
    await onDelete?.call();
  } catch (e) {
    dog('Error on deleteData($key): $e');
    await onFailure?.call(e.toString());
  }
}
