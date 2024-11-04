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

Future updateComment(
  BuildContext context,
  String commentKey,
  String? content,
  List<String>? urls,
  Future Function()? onUpdate,
  Future Function(String error)? onFailure,
) async {
  try {
    await Comment.updateByKey(
      commentKey: commentKey,
      content: content,
      urls: urls,
    );
    await onUpdate?.call();
  } catch (e) {
    dog('Error on updateData: $e');
    await onFailure?.call(e.toString());
  }
}
