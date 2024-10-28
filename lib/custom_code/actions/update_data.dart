// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

Future updateData(
  BuildContext context,
  String key,
  String? category,
  String? title,
  String? content,
  List<String>? urls,
  dynamic extra,
  Future Function()? onUpdate,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!

  try {
    await Data.updateByKey(
      key,
      category,
      title,
      content,
      urls,
      extra,
    );
    await onUpdate?.call();
  } catch (e) {
    dog('Error on updateData: $e');
    await onFailure?.call(e.toString());
  }
}
