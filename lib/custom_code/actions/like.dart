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

Future like(
  String path,
  Future Function(bool value)? onLike,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!

  try {
    final re = await Like.like(
      path,
    );
    await onLike?.call(re);
  } catch (e) {
    // dog('Error on updateData: $e');
    await onFailure?.call(e.toString());
  }
}
