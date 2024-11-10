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

Future sendChatMessage(
  BuildContext context,
  String uidOrRoomId,
  String? text,
  String? url,
  Future Function(String message) onError,
) async {
  // Add your function code here!

  try {
    await ChatService.instance.sendMessage(
      roomId: uidOrRoomId,
      text: text,
      url: url,
    );
  } catch (e) {
    if (onError != null) {
      await onError(e.toString());
      return;
    }

    if (context.mounted) {
      snackbar(
        context,
        e.toString(),
        error: true,
      );
    }
  }
}
