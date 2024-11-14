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
import '/custom_code/actions/super_library.dart';

Future isFollowing(
  BuildContext context,
  String otherUid,
  Future Function(bool value) callback,
) async {
  // Add your function code here!
  if (currentUserUid == null) {
    return callback(false);
  }

  final event = await FeedService.instance.myFollowToOtherRef(otherUid).once();
  if (event.snapshot.exists) {
    callback(true);
    return;
  }
  callback(false);
}
