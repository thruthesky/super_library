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

Future<dynamic> readChatRoom(String roomId) async {
  // Add your function code here!
  final room = await ChatRoom.get(roomId);
  if (room == null) {
    throw SuperLibraryException('chat-room/not-found', 'Chat room not found');
  }
  return room.toJson();
}
