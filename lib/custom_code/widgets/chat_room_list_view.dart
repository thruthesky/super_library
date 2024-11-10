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

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

/// ChatRoomListView
///
/// This widget displays a list of chat rooms
class ChatRoomListView extends StatefulWidget {
  const ChatRoomListView({
    super.key,
    this.width,
    this.height,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Future Function(String roomId)? onTap;

  @override
  State<ChatRoomListView> createState() => _ChatRoomListViewState();
}

class _ChatRoomListViewState extends State<ChatRoomListView> {
  Query get query {
    return ChatService.instance.joinsRef.orderByChild(ChatJoin.field.order);
  }

  @override
  Widget build(BuildContext context) {
    return MyDoc(builder: (data) {
      if (data == null) {
        return const Center(
          child: Text('Please sign in to view chat rooms'),
        );
      }

      return ValueListView(
        query: query,
        builder: (snapshot, fetchMore) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: snapshot.docs.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
            ),
            itemBuilder: (context, index) {
              fetchMore(index);
              final DataSnapshot doc = snapshot.docs[index];
              final join = ChatJoin.fromSnapshot(doc);

              return InkWell(
                onTap: () async {
                  final room = await ChatRoom.get(join.roomId);
                  if (room?.users[myUid] == false) {
                    if (context.mounted) {
                      final re = await confirm(
                        context: context,
                        title: const Text('New chat'),
                        message:
                            const Text('Do you want to join this chat room?'),
                      );
                      if (re != true) {
                        return;
                      }
                    }
                  }

                  if (context.mounted) {
                    widget.onTap?.call(join.roomId) ??
                        // * FlutterFlow provides an action(callback) with empty body
                        // * so, there is less chance that the users would see this toast.
                        // * But if the app is developed by Flutter(Not FlutterFlow), users will see this toast.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Use [onTap] callback action to open chat room. '
                              'Or customize your UI/UX to open chat room. '
                              'Refer to the developer documentation for details.',
                            ),
                          ),
                        );
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        if (join.single == true)
                          UserAvatar(
                            uid: ChatService.instance.getOtherUid(join.roomId),
                            width: 60,
                            height: 60,
                          )
                        else ...[
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  // color: FlutterFlowTheme.of(context).tertiary,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    width: 0.6,
                                  ),
                                ),
                                child: !join.iconUrl.isNullOrEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: CachedNetworkImage(
                                          imageUrl: join.iconUrl!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.groups,
                                        size: 40,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                      ),
                              ),
                              if (!join.photoUrl.isNullOrEmpty)
                                Positioned(
                                  bottom: -8,
                                  right: -8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        width: 4,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        fadeInDuration: Duration.zero,
                                        imageUrl: join.photoUrl!,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        width: 28,
                                        height: 28,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ],
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                join.name ??
                                    join.displayName ??
                                    'No chat room name',
                                style: FlutterFlowTheme.of(context).titleMedium,
                              ),
                              // Row(
                              //   children: [
                              //     if (join.single == false)
                              //       const Icon(
                              //         Icons.supervisor_account_rounded,
                              //         size: 16,
                              //       ),
                              //     if (join.group && join.open == false)
                              //       const Icon(
                              //         Icons.group,
                              //         size: 16,
                              //       ),
                              //     if (join.open == true)
                              //       const Icon(
                              //         Icons.groups,
                              //         size: 16,
                              //       ),
                              //   ],
                              // ),
                              if (join.inviterUid != null &&
                                  join.inviterUid!.isNotEmpty)
                                Text(
                                  'Invited by: ${join.inviterName}',
                                ),
                              if (join.lastText != null &&
                                  join.lastText!.isNotEmpty)
                                Text(
                                  join.lastText!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (join.lastMessageAt != null)
                              Text(
                                join.lastMessageAt!.short,
                                style: FlutterFlowTheme.of(context).labelSmall,
                              ),
                            if (join.newMessageCount > 0)
                              Badge(
                                label: Text('${join.newMessageCount}'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        emptyBuilder: () => const Center(
          child: Text('No chat rooms'),
        ),
      );
    });
  }
}
