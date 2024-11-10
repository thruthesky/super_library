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
import 'package:cloud_firestore/cloud_firestore.dart';

Future unblockUser(String otherUid) async {
  final myRef = firestore.collection('users').doc(myUid);

  await Future.wait([
    myRef.set(
      {
        'blockedUsers': FieldValue.arrayRemove([otherUid])
      },
      SetOptions(merge: true),
    ),
    UserService.instance.myBlockedUsersRef.child(otherUid).set(null)
  ]);

  await ChatService.instance.joinIfRoomExists(otherUid);
}
