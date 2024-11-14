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

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Chat room message list view.
///
/// This widget displays a list of chat messages. This widget can be used in
/// a chat room or any other screen.
///
/// If this widget is shown to screen, it is considered that the user has
/// joined the chat room. So, it has the logic of joining the chat room.
///
/// [roomId] can be the other user uid in 1:1 chat. or it can be a group chat
/// room id or single chat room id.
class ChatMessageListView extends StatefulWidget {
  const ChatMessageListView({
    super.key,
    this.width,
    this.height,
    required this.uidOrRoomId,
    this.onTapProfilePhoto,
  });

  final double? width;
  final double? height;
  final String uidOrRoomId;
  final Future Function(String uid, String displayName, String photoUrl)?
      onTapProfilePhoto;

  @override
  State<ChatMessageListView> createState() => _ChatMessageListViewState();
}

class _ChatMessageListViewState extends State<ChatMessageListView> {
  /// TODO: make these optional parameters
  double get iconSize => 40;
  double get iconPadding => 8;
  double get textPadding => 10;
  double get leftRightBubblePadding => 16;

  StreamSubscription<DatabaseEvent>? roomDataSubscription;

  String get roomId => ChatService.instance.getRoomIdIfUid(
        widget.uidOrRoomId,
      );

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        init();
      }
    });
  }

  init() async {
    // dog('ChatMessageListView.init()');
    await ChatService.instance.join(roomId);
    await ChatService.instance.enter(roomId);

    // * Listen the chat room data change and cache in memory; See [ChatRoom.get] method
    // Listen and update the chat room data in memory. So, it can be used in
    // other widgets. By doing this, the 'users' field of the chat room is
    // always up-to-date in memory.
    roomDataSubscription?.cancel();
    roomDataSubscription =
        ChatService.instance.roomRef(roomId).onValue.listen((event) {
      if (event.snapshot.exists && event.snapshot.value != null) {
        final room = ChatRoom.fromSnapshot(event.snapshot);
        Memory.set(roomId, room);
      }
    });
  }

  @override
  void dispose() {
    roomDataSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return MyDoc(builder: (data) {
    //   if (data == null) {
    //     return const Center(
    //       child: Text('Please sign in to view chat rooms'),
    //     );
    //   }

    return ValueListView(
      reverseQuery: true,
      query: ChatService.instance.messagesRef(roomId),
      builder: (snapshot, fetchMore) {
        /// Clear the unread no of messages when the app displays the message list view.
        /// Anyone can view the chat messages if the chat room is open. That's why [hasLogin] is used.
        if (hasLogin) {
          ChatService.instance.clearNewMessageCount(roomId);
        }

        /// This is the list of chat messages.
        return ListView.separated(
          itemCount: snapshot.docs.length,
          reverse: true,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          // the padding is needed to add space at the last messages.
          // instead of adding padding outside that may look cut when scrolled
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];

            final message = ChatMessage.fromSnapshot(doc);

            /// Anyone can view the chat messages if the chat room is open. That's why [currentUserUid] is used.
            bool isMine = message.senderUid == currentUserUid;
            bool isNotMine = !isMine;

            final listTile = Row(
              // This row aligns the Photo and Name at top
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isNotMine)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      if (widget.onTapProfilePhoto != null) {
                        await widget.onTapProfilePhoto!(
                          message.senderUid,
                          message.displayName ?? '',
                          message.photoUrl ?? '',
                        );
                      }
                    },
                    child: Row(
                      children: [
                        UserAvatar(
                          uid: message.senderUid,
                          width: iconSize,
                          height: iconSize,
                          radius: iconSize / 2.34,
                        ),
                        SizedBox(width: iconPadding),
                      ],
                    ),
                  ),
                Flexible(
                  child: Row(
                    // This row aligns the bubble and the time at their bottom.
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: isMine
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            // TODO: Make the size and color optional
                            UserDisplayName(
                              uid: message.senderUid,
                              fontSize: 12,
                              fontColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            Row(
                              mainAxisAlignment: isMine
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (isMine) ...[
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        // This gives space (to not overlap with other users' icon and message)
                                        left: leftRightBubblePadding,
                                        bottom: 6.0,
                                      ),
                                      child: Text(
                                        message.createdAt.toDateTime.short,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: iconPadding),
                                ],

                                /// Chat message text
                                if (message.text != null &&
                                    message.text!.isNotEmpty)
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.all(textPadding),
                                      decoration: BoxDecoration(
                                        color: isMine
                                            ? FlutterFlowTheme.of(context)
                                                .accent3
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        borderRadius: BorderRadius.only(
                                          topLeft: isMine
                                              ? const Radius.circular(16)
                                              : Radius.zero,
                                          topRight: isNotMine
                                              ? const Radius.circular(16)
                                              : Radius.zero,
                                          bottomLeft: const Radius.circular(16),
                                          bottomRight:
                                              const Radius.circular(16),
                                        ),
                                      ),
                                      child: BlockedUser(
                                          uid: message.senderUid,
                                          builder: (re) {
                                            /// TODO: Make the blocked user message customizable
                                            return Text(
                                              re
                                                  ? 'Blocked user message'
                                                  : message.text!,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium,
                                            );
                                          }),
                                    ),
                                  ),

                                /// Chat message Date & Time
                                if (isNotMine) ...[
                                  SizedBox(width: iconPadding),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 6.0,
                                        right: leftRightBubblePadding,
                                      ),
                                      child: Text(
                                        message.createdAt.toDateTime.short,
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            if (message.url != null &&
                                message.url!.isNotEmpty) ...[
                              SizedBox(height: iconPadding),
                              Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.8),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: isMine
                                        ? const Radius.circular(16)
                                        : Radius.zero,
                                    topRight: isNotMine
                                        ? const Radius.circular(16)
                                        : Radius.zero,
                                    bottomLeft: const Radius.circular(16),
                                    bottomRight: const Radius.circular(16),
                                  ),
                                ),
                                child:
                                    CachedNetworkImage(imageUrl: message.url!),
                              ),
                            ],

                            /// Preview of the URL
                            if (message.previewUrl != null)
                              BlockedUser(
                                uid: message.senderUid,
                                builder: (re) {
                                  if (re) {
                                    return const SizedBox.shrink();
                                  }
                                  return Container(
                                    padding: const EdgeInsets.only(top: 8),
                                    width: 220,
                                    child: SitePreview(
                                      data: SitePreviewData(
                                        url: message.previewUrl,
                                        title: message.previewTitle,
                                        description: message.previewDescription,
                                        imageUrl: message.previewImageUrl,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            return Container(
              // The key is to prevent image blinking when there is a new message.
              key: ValueKey(message.id),
              child: listTile,
            );
          },
        );
      },
      emptyBuilder: () {
        return Center(
          child: Text('No chat messages yet'.tr(context)),
        );
      },
    );
    // });
  }
}
