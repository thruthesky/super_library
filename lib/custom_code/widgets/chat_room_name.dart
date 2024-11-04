// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';

import '../actions/super_library.dart';

/// [ChatRoomName] is a custom widget that displays the name of a chat room.
///
/// If it's uid, then it will display the user name and photo.
/// If it's a room id, then it will display the room name and the icon url.
class ChatRoomName extends StatefulWidget {
  const ChatRoomName({
    super.key,
    this.width,
    this.height,
    required this.uidOrRoomId,
  });

  final double? width;
  final double? height;
  final String uidOrRoomId;

  @override
  State<ChatRoomName> createState() => _ChatRoomNameState();
}

class _ChatRoomNameState extends State<ChatRoomName> {
  @override
  Widget build(BuildContext context) {
    bool single = isUid(widget.uidOrRoomId) ||
        ChatService.instance.isSingleChatRoom(widget.uidOrRoomId);
    if (single) {
      String uid = isUid(widget.uidOrRoomId)
          ? widget.uidOrRoomId
          : ChatService.instance.getOtherUid(widget.uidOrRoomId);
      return Value(
        ref: userRef(uid),
        builder: (data, ref) {
          final user = UserData.fromJson(data, uid);
          return Row(
            children: [
              UserAvatar(uid: user.uid),
              const SizedBox(width: 16),
              Text(
                user.displayName,
              ),
            ],
          );
        },
      );
    } else {
      return Value(
        ref: roomRef(widget.uidOrRoomId),
        builder: (data, ref) {
          final room = ChatRoom.fromJson(data, widget.uidOrRoomId);
          return Row(
            children: [
              if (room.iconUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: room.iconUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(width: 16),
              Text(
                room.name,
              ),
            ],
          );
        },
      );
    }

    // return Value(
    //   ref: ChatService.instance.isSingleChatRoom(widget.uidOrRoomId)
    //       ? UserService.instance
    //           .databaseUserRef(
    //               ChatService.instance.getOtherUid(widget.uidOrRoomId))
    //           .child(UserData.field.displayName)
    //       : ChatService.instance.roomsRef
    //           .child(widget.uidOrRoomId)
    //           .child(ChatRoom.field.name),
    //   builder: (chatRoomName, ref) {
    //     final String chatRoomNameValue = chatRoomName ?? "Chat Room";
    //     return Text(
    //       chatRoomNameValue,
    //     );
    //   },
    // );
  }
}
