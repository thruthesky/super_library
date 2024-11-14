// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/feed_api.dart';

Future unfollow(
  BuildContext context,
  String otherUid,
  Future Function()? onUnfollow,
  Future Function(String error)? onFailure,
) async {
  // Add your function code here!
  try {
    await FeedService.instance.unfollow(otherUid);
    await onUnfollow?.call();
  } catch (e) {
    await onFailure?.call(e.toString());
  }
}
