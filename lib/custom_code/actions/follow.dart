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

Future follow(
  BuildContext context,
  String otherUid,
  Future Function()? onFollow,
  Future Function(String error)? onFailure,
) async {
  try {
    await FeedService.instance.follow(otherUid);
    await onFollow?.call();
  } catch (e) {
    await onFailure?.call(e.toString());
  }
}
