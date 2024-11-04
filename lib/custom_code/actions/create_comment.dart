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

Future createComment(
  BuildContext context,
  dynamic data,
  String? content,
  List<String>? urls,
  dynamic extra,
  Future Function(String key)? onCreate,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!

  // Prepare
  dynamic parent = data;
  bool isParentData = data['rootKey'] == null;

  // bool isParentComment = !isParentData;

  /// Get the root key. If the rootKey is empty then, the data is the root data.
  String rootKey = data['rootKey'] ?? data['key'];

  ///
  String? parentKey;
  if (isParentData) {
    parentKey = null;
  } else {
    parentKey = parent['key'];
  }

  dog('--> createComment rootKey: $rootKey, parentKey: $parentKey, content: $content, urls: $urls');

  try {
    final ref = await Comment.create(
      rootKey: rootKey,
      parentKey: parentKey,
      content: content,
      urls: urls,
    );
    await onCreate?.call(ref.key!);
  } catch (e) {
    dog('Error on createComment $e');
    await onFailure?.call(e.toString());
  }
}
