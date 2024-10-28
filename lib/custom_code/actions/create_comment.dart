// Automatic FlutterFlow imports
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

  /// Get the root key. If the rootKey is empty then, the data is the root data.
  String rootKey = data['rootKey'] ?? data['key'];

  /// Get the rootKey is empty, then current data is data. and it's the first level comment. So, parent will be null.
  /// If there is rootKey and the current data is a comment.
  /// If there is rootKey and the parentKey is empty then, the current data is the first leve comment. And it will create the 2nd level comment.
  String? parentKey;
  if (data['rootKey'] == null) {
    parentKey = null;
  } else {
    parentKey = data['parentKey'] ?? data['key'];
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
