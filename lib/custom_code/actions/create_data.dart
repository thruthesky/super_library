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

Future createData(
  BuildContext context,
  String category,
  String? title,
  String? content,
  List<String>? urls,
  dynamic extra,
  Future Function(String key)? onCreate,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!

  try {
    final ref = await Data.create(
      category: category,
      title: title,
      content: content,
      urls: urls,
      data: extra,
    );
    await onCreate?.call(ref.key!);
  } catch (e) {
    dog('Error on createData $e');
    await onFailure?.call(e.toString());
  }
}
