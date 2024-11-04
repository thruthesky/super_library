// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';
import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/foundation.dart';

import 'package:collection/collection.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_ui_database/firebase_ui_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:dio/dio.dart';
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Helpers
///
/// Helper functions, variables -------------------------------------------------------------------
///
FirebaseDatabase get database => SuperLibrary.instance.database;
fs.FirebaseFirestore get firestore => fs.FirebaseFirestore.instance;

/// [currentUserUid] returns the current user's UID. It returns null if the user is not signed in.
String? get currentUserUid => fa.FirebaseAuth.instance.currentUser?.uid;

/// [myUid] returns the current user's UID. It throws an exception if the user is not signed in.
String get myUid {
  if (fa.FirebaseAuth.instance.currentUser == null) {
    throw Exception('[myUid] is called but the user is not signed in');
  }
  return fa.FirebaseAuth.instance.currentUser!.uid;
}

/// [signedIn] returns true if the user is signed in with FirebaseAuth. Otherwise, it returns false.
bool get signedIn => fa.FirebaseAuth.instance.currentUser != null;
bool get notSignedIn => !signedIn;

/// Database reference for the current user
DatabaseReference get myRef => userRef(myUid);

DatabaseReference dataRef(String k) => Ref.data.child(k);

/// EO Helpers -------------------------------------------------------------------------------------

/// AuthStateChanges
///
/// Use this widget to listen to the login user's authentication state changes
/// and rebuild the UI accordingly. It simply wraps
/// [FirebaseAuth.instance.authStateChanges] insdie a [StreamBuilder].
///
/// [builder] is the UI builder callback that will be called when the user's
/// authentication state changes.
///
class AuthStateChanges extends StatelessWidget {
  const AuthStateChanges({super.key, required this.builder});

  final Widget Function(fa.User?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // To reduce the flickering
      initialData: fa.FirebaseAuth.instance.currentUser,
      stream: fa.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        final user = snapshot.data;
        return builder(user);
      },
    );
  }
}

/// Rebuild the widget based on the user's block status.
///
/// If the uid of the user is blocked by the login user, the parameter of the
/// [builder] will be true. Otherwise, it will be false.
class BlockedUser extends StatelessWidget {
  const BlockedUser({super.key, required this.uid, required this.builder});
  final String uid;
  final Widget Function(bool) builder;

  @override
  Widget build(BuildContext context) {
    return MyDoc(
      builder: (userData) {
        if (userData == null) {
          // Fix by @thruthesky at Nov 3, 2024. It should call false if the user data is not found.
          return builder(false);
        }

        final List<String> blockedUsers =
            List<String>.from((userData['blockedUsers'] as List?) ?? []);

        return builder(blockedUsers.contains(uid));
      },
    );
  }
}

/// Realtime database chat join model
class ChatJoin {
  /// For field names
  static const field = (
    singleOrder: 'singleOrder',
    groupOrder: 'groupOrder',
    openOrder: 'openOrder',
    order: 'order',
    lastMessageUid: 'lastMessageUid',
    lastMessageAt: 'lastMessageAt',
    lastMessageDeleted: 'lastMessageDeleted',
    lastText: 'lastText',
    lastUrl: 'lastUrl',
    lastProtocol: 'lastProtocol',
    name: 'name',
    iconUrl: 'iconUrl',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
    inviterUid: 'inviterUid',
    inviterName: 'inviterName',
    newMessageCount: 'newMessageCount',
  );

  final String roomId;
  final int? singleOrder;
  final int? groupOrder;
  final int? openOrder;
  final int order;
  final String? lastMessageUid;
  final DateTime? lastMessageAt;
  final bool? lastMessageDeleted;
  final String? lastText;
  final String? lastUrl;
  final String? lastProtocol;

  final int newMessageCount;

  // chat room name
  final String? name;
  // chat room icon url
  final String? iconUrl;

  // message sender's display name
  final String? displayName;

  // message sender's photo url
  final String? photoUrl;

  bool get group => groupOrder != null;
  bool get single => singleOrder != null;
  bool get open => openOrder != null;

  // Inviter's uid and name when the user is invited to the chat room.
  // Use this to display who invited who.
  String? inviterUid;
  String? inviterName;

  ChatJoin({
    required this.roomId,
    required this.singleOrder,
    required this.groupOrder,
    required this.openOrder,
    required this.order,
    required this.lastMessageUid,
    required this.lastMessageAt,
    required this.lastMessageDeleted,
    required this.lastText,
    required this.lastUrl,
    required this.lastProtocol,
    this.newMessageCount = 0,
    this.name,
    this.iconUrl,
    this.displayName,
    this.photoUrl,
    this.inviterUid,
    this.inviterName,
  });

  factory ChatJoin.fromSnapshot(DataSnapshot snapshot) {
    return ChatJoin.fromJson(snapshot.value as Map, snapshot.key!);
  }

  factory ChatJoin.fromJson(Map<dynamic, dynamic> json, String roomId) {
    return ChatJoin(
      roomId: roomId,
      singleOrder: json[field.singleOrder],
      groupOrder: json[field.groupOrder],
      openOrder: json[field.openOrder],
      order: json[field.order] is ServerValue
          ? DateTime.now().millisecondsSinceEpoch
          : json[field.order],
      lastMessageUid: json[field.lastMessageUid],
      lastMessageAt:
          DateTime.fromMillisecondsSinceEpoch(json[field.lastMessageAt] ?? 0),
      lastMessageDeleted: json[field.lastMessageDeleted],
      lastUrl: json[field.lastUrl],
      lastText: json[field.lastText],
      lastProtocol: json[field.lastProtocol],
      newMessageCount: json[field.newMessageCount] ?? 0,
      name: json[field.name],
      iconUrl: json[field.iconUrl],
      displayName: json[field.displayName],
      photoUrl: json[field.photoUrl],
      inviterUid: json[field.inviterUid],
      inviterName: json[field.inviterName],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
      field.singleOrder: singleOrder,
      field.groupOrder: groupOrder,
      field.openOrder: openOrder,
      field.order: order,
      field.lastMessageUid: lastMessageUid,
      field.lastMessageAt: lastMessageAt,
      field.lastMessageDeleted: lastMessageDeleted,
      field.lastText: lastText,
      field.lastUrl: lastUrl,
      field.lastProtocol: lastProtocol,
      field.newMessageCount: newMessageCount,
      field.name: name,
      field.iconUrl: iconUrl,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.inviterUid: inviterUid,
      field.inviterName: inviterName,
    };
  }

  @override
  String toString() {
    return 'ChatJoin(${toJson()})';
  }
}

class ChatMessage {
  /// Field names for the Chat Message Model
  static const field = (
    id: 'id',
    roomId: 'roomId',
    text: 'text',
    url: 'url',
    senderUid: 'uid',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
    createdAt: 'createdAt',
    replyTo: 'replyTo',
    deleted: 'deleted',
    updatedAt: 'updatedAt',
    previewUrl: 'previewUrl',
    previewTitle: 'previewTitle',
    previewDescription: 'previewDescription',
    previewImageUrl: 'previewImageUrl',
    protocol: 'protocol',
  );

  String? id;

  /// [roomId] is not saved in database. It can be found in the path.
  String? roomId;
  String senderUid;
  String? displayName;

  /// [photoUrl] is pertaining to the sender's profile photo url,
  /// not the attached photo in message itself.
  String? photoUrl;
  int createdAt;
  int? updatedAt;
  int? order;
  String? text;

  /// [url] is used for the attached url in the message
  String? url;
  String? protocol;
  final bool deleted;

  String? previewUrl;
  String? previewTitle;
  String? previewDescription;
  String? previewImageUrl;

  ChatMessage? replyTo;

  bool get isUpdated => updatedAt != null;
  bool get isProtocol => protocol != null && protocol!.isNotEmpty;

  DatabaseReference get ref =>
      ChatService.instance.messagesRef(roomId!).child(id!);

  ChatMessage({
    this.id,
    required this.roomId,
    this.text,
    this.url,
    this.protocol,
    required this.senderUid,
    this.displayName,
    this.photoUrl,
    required this.createdAt,
    this.replyTo,
    this.deleted = false,
    this.updatedAt,
    this.previewUrl,
    this.previewTitle,
    this.previewDescription,
    this.previewImageUrl,
  });

  factory ChatMessage.fromSnapshot(DataSnapshot snapshot) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);
    return ChatMessage.fromJson(
      data,
      snapshot.key!,
      snapshot.ref.parent!.key,
    );
  }

  static ChatMessage fromJson(
    Map<String, dynamic> json,
    String id, [
    String? roomId,
  ]) {
    final replyTo = json[field.replyTo] == null
        ? null
        : Map<String, dynamic>.from(json[field.replyTo] as Map);

    // dog('ChatMessage.fromJson: $json');
    return ChatMessage(
      id: id,
      roomId: roomId,
      text: json[field.text],
      url: json[field.url],
      protocol: json[field.protocol],
      senderUid: json[field.senderUid],
      displayName: json[field.displayName],
      photoUrl: json[field.photoUrl],
      createdAt: json[field.createdAt],
      replyTo: replyTo == null
          ? null
          : ChatMessage.fromJson(replyTo, replyTo[field.id]),
      // Added '?? false' because this it RTDB
      // Reason: There is no use for saving false in deleted.
      deleted: json[field.deleted] ?? false,
      updatedAt: json[field.updatedAt],
      previewUrl: json[field.previewUrl],
      previewTitle: json[field.previewTitle],
      previewDescription: json[field.previewDescription],
      previewImageUrl: json[field.previewImageUrl],
    );
  }

  static Map<String, dynamic> json({
    String? text,
    String? url,
    String? protocol,
    required String senderUid,
    String? displayName,
    String? photoUrl,
    required Map<String, String> createdAt,
    dynamic replyTo,
    bool? deleted,
    Map<String, String>? updatedAt,
    String? previewUrl,
    String? previewTitle,
    String? previewDescription,
    String? previewImageUrl,
  }) {
    return {
      field.text: text,
      field.url: url,
      field.protocol: protocol,
      field.senderUid: senderUid,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.createdAt: createdAt,
      field.replyTo: replyTo?.toJson(),
      field.deleted: deleted,
      field.updatedAt: updatedAt,
      field.previewUrl: previewUrl,
      field.previewTitle: previewTitle,
      field.previewDescription: previewDescription,
      field.previewImageUrl: previewImageUrl,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      field.text: text,
      field.url: url,
      field.protocol: protocol,
      field.senderUid: senderUid,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.createdAt: createdAt,
      field.replyTo: replyTo?.toJson(),
      field.deleted: deleted,
      field.updatedAt: updatedAt,
      field.previewUrl: previewUrl,
      field.previewTitle: previewTitle,
      field.previewDescription: previewDescription,
      field.previewImageUrl: previewImageUrl,
    };
  }
}

class ChatRoom {
  /// Field names used for the Firestore document
  static const field = (
    name: 'name',
    description: 'description',
    iconUrl: 'iconUrl',
    users: 'users',
    blockedUsers: 'blockedUsers',
    masterUsers: 'masterUsers',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    open: 'open',
    openCreatedAt: 'openCreatedAt',
    single: 'single',
    group: 'group',
    lastMessageAt: 'lastMessageAt',
    allMembersCanInvite: 'allMembersCanInvite',
  );

  /// [id] is the chat room id. This is the key of the chat room data.
  String id;

  /// [ref] is the data reference of the chat room.
  DatabaseReference get ref => ChatService.instance.roomsRef.child(id);

  /// [name] is the chat room name. If it does not exist, it is empty.
  String name;

  /// [description] is the chat room description. If it does not exist, it is empty.
  String description;

  /// The icon url of the chat room. optinal.
  String? iconUrl;

  /// [users] is the uid list of users who are join the room
  // Map<String, ChatRoomUser> users;
  Map<String, bool> users;

  /// Returns list of uids of members
  List<String> get userUids => users.keys.toList();

  /// [noOfUsers] is the number of users in the chat room.
  int get noOfUsers => users.length;

  bool get joined => userUids.contains(myUid);

  /// Map of `blocked-user-uid: true`.
  Map<String, bool> blockedUsers;
  List<String> get blockedUids => blockedUsers.keys.toList();

  List<String> masterUsers;

  DateTime createdAt;
  DateTime updatedAt;

  /// [open] is true if the chat room is open chat
  bool open;

  /// [openCreatedAt] is the time when the open chat room was creatd.
  /// It is null if the chat room is not open chat.
  /// It is used to sort the open chat rooms.
  DateTime? openCreatedAt;

  /// [single] is true if the chat room is single chat or 1:1.
  bool single;

  /// [group] is true if the chat room is group chat.
  bool group;

  /// [lastMessageAt] is the time when last message was sent to chat room.
  DateTime? lastMessageAt;

  bool allMembersCanInvite = false;

  /// Uids for single chat is combination of both users' uids separated by "---"
  /// Returns list of uids based on the room id.
  List<String> get uidsFromRoomId => id.contains("---") ? id.split("---") : [];

  ChatRoom({
    required this.id,
    required this.name,
    required this.description,
    this.iconUrl,
    required this.open,
    this.openCreatedAt,
    required this.single,
    required this.group,
    required this.users,
    required this.masterUsers,
    this.blockedUsers = const {},
    required this.createdAt,
    required this.updatedAt,
    this.lastMessageAt,
    this.allMembersCanInvite = false,
  });

  /// Return the chat room object from the snapshot.
  factory ChatRoom.fromSnapshot(DataSnapshot data) {
    if (data.exists == false || data.value == null) {
      dog("data does not exists or is null");
    }
    if (data.value is int) {
      dog("data.value is int");
    }
    return ChatRoom.fromJson(
      (Map<String, dynamic>.from(data.value as Map)),
      data.key!,
    );
  }

  /// Return the chat room object from the json.
  factory ChatRoom.fromJson(Map<dynamic, dynamic> json, String id) {
    return ChatRoom(
      id: id,
      name: json[field.name] ?? '',
      description: json[field.description] ?? '',
      iconUrl: json[field.iconUrl],
      open: json[field.open],
      openCreatedAt: json[field.openCreatedAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.openCreatedAt])
          : DateTime.now(),
      single: json[field.single],
      group: json[field.group],
      users: json[field.users] is Map
          ? Map<String, bool>.from(json[field.users])
          : {},
      masterUsers: List<String>.from(json[field.masterUsers]),
      blockedUsers: Map<String, bool>.from(json[field.blockedUsers] ?? {}),
      createdAt: json[field.createdAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.createdAt])
          : DateTime.now(),
      updatedAt: json[field.updatedAt] is num
          ? DateTime.fromMillisecondsSinceEpoch(json[field.updatedAt])
          : DateTime.now(),
      lastMessageAt: json[field.lastMessageAt] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json[field.lastMessageAt]),
      allMembersCanInvite: json[field.allMembersCanInvite] ?? false,
    );
  }

  /// Converts the model into Map<String, dynamic>
  ///
  /// * Use it only for debug purpose !!
  Map<String, dynamic> toJson() {
    return {
      field.name: name,
      field.description: description,
      field.iconUrl: iconUrl,
      field.open: open,
      field.openCreatedAt: openCreatedAt,
      field.single: single,
      field.group: group,
      field.users: users,
      field.masterUsers: masterUsers,
      field.blockedUsers: blockedUsers,
      field.createdAt: createdAt.millisecondsSinceEpoch,
      field.updatedAt: updatedAt.millisecondsSinceEpoch,
      field.lastMessageAt: lastMessageAt?.millisecondsSinceEpoch,
      field.allMembersCanInvite: allMembersCanInvite,
    };
  }

  /// toString
  @override
  String toString() {
    return 'ChatRoom(${toJson()})';
  }

  /// [create] creates a new chat room.
  ///
  /// Returns the database reference of the chat room.
  ///
  /// If [id] is null, this will make new room id (preferred for group chat)
  static Future<DatabaseReference> create({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    bool open = false,
    // Group == false means the chat room is single chat
    bool group = true,
    bool single = false,
    // String? password, (NOT IMPLEMENTED YET)
    Map<String, bool> users = const {},
    List<String>? masterUsers,
    bool allMembersCanInvite = false,
  }) async {
    // TODO: Should (create and join) be one write upon create?
    if (single == true && (group == true || open == true)) {
      throw 'chat-room-create/single-cannot-be-group-or-open Single chat room cannot be group or open';
    }
    if (single == false && group == false) {
      throw 'chat-room-create/single-or-group Single or group chat room must be selected';
    }

    final newRoom = {
      if (name != null) field.name: name,
      if (description != null) field.description: description,
      if (iconUrl != null) field.iconUrl: iconUrl,
      field.open: open,
      if (open) field.openCreatedAt: ServerValue.timestamp,
      field.single: single,
      field.group: group,
      // if (invitedUsers != null) field.invitedUsers: invitedUsers,
      field.users: users,
      field.masterUsers: [myUid],
      field.allMembersCanInvite: allMembersCanInvite,
      field.createdAt: ServerValue.timestamp,
      field.updatedAt: ServerValue.timestamp,
    };

    DatabaseReference newChatRoomRef;
    if (id == null) {
      newChatRoomRef = ChatService.instance.roomsRef.push();
    } else {
      newChatRoomRef = ChatService.instance.roomsRef.child(id);
    }

    /// Create the chat room. It's update method but it's creating a new chat room.
    await newChatRoomRef.update(newRoom);
    return newChatRoomRef;
  }

  /// [createSingle] creates a new single chat room.
  static Future<DatabaseReference> createSingle(
    String otherUid,
  ) async {
    ///
    final ref = await create(
      group: false,
      open: false,
      single: true,
      id: ChatService.instance.makeSingleChatRoomId(myUid, otherUid),
      users: {
        myUid: true,
        otherUid: false,
      },
      masterUsers: [myUid],
    );

    return ref;
  }

  /// [get] gets the cached chat room by id.
  ///
  /// Note that the chat room data is updated in realtime by [ChatMessageListView] widget.
  static Future<ChatRoom?> get(
    String id, {
    bool cache = true,
  }) async {
    if (cache && Memory.get(id) != null) {
      return Memory.get(id) as ChatRoom;
    }
    final snapshot = await ChatService.instance.roomRef(id).get();
    if (snapshot.exists == false) {
      dog('ChatRoom.get() -> Chat room not found. id: $id');
      return null;
    }
    final room = ChatRoom.fromSnapshot(snapshot);

    Memory.set(id, room);
    return room;
  }

  /// [update] updates the chat room.
  ///
  ///
  /// Note that the chat room cannot be turn into single chat room if it's group chat room.
  Future<void> update({
    String? name,
    String? description,
    String? iconUrl,
    bool? open,
    bool? allMembersCanInvite,
  }) async {
    if (single == true && (group == true || open == true)) {
      throw SuperLibraryException(
        'chat-room-update/single-cannot-be-group-or-open',
        'Single chat room cannot be group or open',
      );
    }
    if (single == false && group == false) {
      throw SuperLibraryException(
        'chat-room-update/single-or-group',
        'Single or group chat room must be selected',
      );
    }
    final updateData = {
      field.name: name,
      field.description: description,
      field.iconUrl: iconUrl,
      field.open: open,
      field.single: single,
      field.group: group,
      field.allMembersCanInvite: allMembersCanInvite,
      field.updatedAt: ServerValue.timestamp,
    };

    await ref.update(updateData);
  }
}

class ChatService {
  static ChatService? _instance;
  static ChatService get instance => _instance ??= ChatService._();

  ChatService._();

  DatabaseReference messagesRef(String roomId) =>
      database.ref('chat/messages').child(roomId);

  /// Get the chat room join data reference of the login user.
  DatabaseReference get joinsRef => database.ref('chat/joins').child(myUid);

  DatabaseReference get roomsRef => database.ref('chat/rooms');

  DatabaseReference roomRef(String roomId) =>
      database.ref('chat/rooms').child(roomId);

  DatabaseReference get mySettingRef =>
      database.ref().child('chat').child('settings').child(myUid);

  /// Send a message to the chat room.
  ///
  /// [roomId] may be a user's uid and it can be the chat room id.
  Future sendMessage({
    required String roomId,
    String? text,
    String? url,
  }) async {
    // Add your function code here!

    // dog('sendMessage() -> roomId: $roomId, text: $text, url: $url');

    // Check if the user is blocked by login user
    if (UserService.instance.hasBlocked(otherUidOrRoomId(roomId))) {
      throw SuperLibraryException('chat/send-message', 'User is blocked');
    }

    // Convert the single chat room id if it's single chat room.
    roomId = convertIfUidToSingleChatRoomId(roomId);

    // Get the cached user data
    final my = await UserData.get(myUid);

    // Send(save/create) a chat message into chat room.
    //
    final message = ChatMessage.json(
      senderUid: myUid,
      displayName: my?.displayName,
      photoUrl: my?.photoUrl,
      url: url,
      createdAt: ServerValue.timestamp,
      text: text,
    );

    final messageRef = messagesRef(roomId).push();
    await messageRef.set(message);

    // Get server timestamp
    final createdAtSnapshot =
        await messageRef.child(ChatMessage.field.createdAt).get();
    final timestamp = createdAtSnapshot.value as int;

    final moreImportant = int.parse("-1$timestamp");
    final lessImportant = -1 * timestamp;

    // Get the cached chat room data. Note that the chat room data is updated
    // in realtime by [ChatMessageListView] widget.
    final room = await ChatRoom.get(roomId);
    if (room == null) {
      // dog('sendMessage() -> Chat room not found. roomId: $roomId');
      throw SuperLibraryException('send-message', 'Chat room not found');
    }

    final Map<String, Object?> updates = {};
    const f = ChatJoin.field;
    for (String uid in room.userUids) {
      // dog('sendMessage() user uid: $uid');
      if (uid == myUid) {
        // If it's my join data
        // The order must not have -11 infront since I have already read that
        // chat room. (I am in the chat room)
        updates['chat/joins/$uid/${room.id}/order'] = lessImportant;
        if (room.single) {
          updates['chat/joins/$uid/${room.id}/${f.singleOrder}'] =
              lessImportant;
        }
        if (room.group) {
          updates['chat/joins/$uid/${room.id}/${f.groupOrder}'] = lessImportant;
        }
        if (room.open) {
          updates['chat/joins/$uid/${room.id}/${f.openOrder}'] = lessImportant;
        }
        updates['chat/settings/$uid/${f.newMessageCount}/${room.id}'] = null;
      } else {
        updates['chat/joins/$uid/${room.id}/order'] = moreImportant;
        if (room.single) {
          updates['chat/joins/$uid/${room.id}/${f.singleOrder}'] =
              moreImportant;
        }
        if (room.group) {
          updates['chat/joins/$uid/${room.id}/${f.groupOrder}'] = moreImportant;
        }
        if (room.open) {
          updates['chat/joins/$uid/${room.id}/${f.openOrder}'] = moreImportant;
        }

        /// Increment the unread message count if the message is not
        /// - join,
        /// - left,
        /// - or invitation-not-sent
        // TODO: Protocol support
        // if (protocol != ChatProtocol.join &&
        //     protocol != ChatProtocol.left &&
        //     protocol != ChatProtocol.invitationNotSent) {

        updates['chat/settings/$uid/${f.newMessageCount}/${room.id}'] =
            ServerValue.increment(1);
        updates['chat/joins/$uid/${room.id}/${f.newMessageCount}'] =
            ServerValue.increment(1);

        // }
      }

      updates['chat/joins/$uid/${room.id}/${f.lastMessageAt}'] = timestamp;

      // Add more about chat room info, to display the chat room list
      // information without referring to the chat room.
      updates['chat/joins/$uid/${room.id}/${f.lastMessageUid}'] = myUid;
      updates['chat/joins/$uid/${room.id}/${f.lastText}'] = text;
      updates['chat/joins/$uid/${room.id}/${f.lastUrl}'] = url;
      // TODO: Protocol support
      // updates['chat/joins/$uid/${room.id}/${f.lastProtocol}'] = protocol;
      updates['chat/joins/$uid/${room.id}/${f.lastMessageDeleted}'] = null;

      // If it's single chat, add the my information to the other user's join
      if (room.single && uid != myUid) {
        updates['chat/joins/$uid/${room.id}/${f.displayName}'] =
            my?.displayName;
        updates['chat/joins/$uid/${room.id}/${f.photoUrl}'] = my?.photoUrl;
      } else if (room.group) {
        updates['chat/joins/$uid/${room.id}/${f.name}'] = room.name;
        updates['chat/joins/$uid/${room.id}/${f.iconUrl}'] = room.iconUrl;
      }

      // If it's group chat, add the sender's information
      if (room.group) {
        updates['chat/joins/$uid/${room.id}/${f.displayName}'] =
            my?.displayName;
        updates['chat/joins/$uid/${room.id}/${f.photoUrl}'] = my?.photoUrl;
      }
    }

    // Must save the last message at in room to properly reorder it upon seening the message.
    updates['chat/rooms/${room.id}/${f.lastMessageAt}'] = timestamp;
    await database.ref().update(updates);

    // Write the data first for the speed of performance and then update the
    // other user data.
    // See README.md for details
    if (room.single) {
      UserData? user = await UserData.get(getOtherUid(roomId));
      await database.ref().update({
        'chat/joins/$myUid/${room.id}/${f.displayName}': user?.displayName,
        'chat/joins/$myUid/${room.id}/${f.photoUrl}': user?.photoUrl,
      });
    }

    updateUrlPreview(messageRef.key!, roomId, text);
  }

  /// Clear the new message count of the chat room.
  ///
  /// Use this method to clear the new message count of the chat room.
  Future<void> clearNewMessageCount(String roomId) async {
    final room = await ChatRoom.get(roomId);
    if (room == null) {
      throw SuperLibraryException(
          'chat/clear-new-message-count', 'Room not found');
    }

    final updates = {
      'chat/settings/$myUid/${ChatJoin.field.newMessageCount}/$roomId': null,
      'chat/joins/$myUid/$roomId/${ChatJoin.field.newMessageCount}': null,
    };

    await database.ref().update(updates);
  }

  Future<void> updateUrlPreview(
      String messageId, String roomId, String? text) async {
    if (text == null) return;

    final SitePreviewData? previewSite = await loadSitePreview(text: text);
    if (previewSite == null) return;

    await database.ref('chat/messages/$roomId/$messageId').update({
      ChatMessage.field.previewUrl: previewSite.url,
      ChatMessage.field.previewTitle: previewSite.title,
      ChatMessage.field.previewDescription: previewSite.description,
      ChatMessage.field.previewImageUrl: previewSite.imageUrl,
      // TODO how about the siteName?
      // previewSite.siteName
    });
  }

  String singleChatRoomJoinSeparator = '---';

  ///
  String makeSingleChatRoomId(String? loginUid, String? otherUid) {
    if (loginUid == null) {
      throw SuperLibraryException('makeSingleChatRoomId', 'loginUid is null');
    }
    if (otherUid == null) {
      throw SuperLibraryException('makeSingleChatRoomId', 'otherUid is null');
    }
    final arr = [loginUid, otherUid];
    arr.sort();
    return arr.join(singleChatRoomJoinSeparator);
  }

  /// Returns the single-chat room-id if the input string is a user uid. If the
  /// input string is not a user uid, it returns the same string.
  ///
  /// If the [otherUid] is not a uid, it should be the chat room id. then, it
  /// will return it as it is.
  ///
  /// If the [otherUid] is a uid, it will return the single chat room id.
  ///
  /// Why?
  /// - For listing chat messages and seding a chat message, it needs to know
  /// the chat room id.
  /// - To make it clean code, it will automatically convert the other uid into
  /// chat room id. So, the developer can simply pass the other user's uid or
  /// chat room id.
  String convertIfUidToSingleChatRoomId(String otherUid) {
    // If it's a node key, return it as it is.
    if (otherUid.startsWith('-')) {
      return otherUid;
    }
    // If it's a node key, return it as it is.
    if (otherUid.length == 20) {
      return otherUid;
    }
    // If it's a single chat room id, return it as it is.
    if (isSingleChatRoom(otherUid)) {
      return otherUid;
    }
    // If it's a UID, then convert it to single chat room id.
    if (otherUid.length == 28) {
      return makeSingleChatRoomId(myUid, otherUid);
    }

    // If it does not look like a node key, nor a single chat room id, nor a UID,
    // then return it as it is.
    return otherUid;
  }

  /// [isSingleChatRoom] returns true if the room id is single chat room.
  bool isSingleChatRoom(String roomId) {
    return roomId.contains(singleChatRoomJoinSeparator);
  }

  /// [getOtherUid] returns the other user's uid from the single chat room id.
  String getOtherUid(String singleChatRoomId) {
    // dog('getOtherUid: $singleChatRoomId');
    final uids = singleChatRoomId.split(singleChatRoomJoinSeparator);
    if (uids.length != 2) {
      throw SuperLibraryException(
        'getOtherUid',
        'Invalid single chat room id',
      );
    }
    return uids.firstWhere((uid) => uid != myUid);
  }

  // TODO where to put this
  Future<int> getDatabaseServerTimestamp() async {
    final ref = database.ref().child('chat').child('-info').child('timestamp');
    await ref.set(ServerValue.timestamp);
    final snapshot = await ref.get();
    return snapshot.value as int;
  }

  /// Join a chat room
  ///
  /// This method is used to join a chat room.
  ///
  /// [roomId] may be a user uid. It can be the chat room id.
  ///
  /// Where:
  /// - It is called in chat message list view.
  ///
  /// Logic:
  /// - It update the room.users with current user's uid.
  /// - If it's single chat room, it will add the other user's uid in the
  ///   room.users field with requireConsent: true.
  Future<void> join(String roomId) async {
    dog("Joining into roomId: $roomId");

    // Check if the user is blocked by login user
    if (UserService.instance.hasBlocked(otherUidOrRoomId(roomId))) {
      throw SuperLibraryException('chat/join', 'User is blocked');
    }

    // Prepare
    const f = ChatJoin.field;
    // Get the chat room data from the database.
    ChatRoom? room = await ChatRoom.get(roomId, cache: false);

    if (room == null) {
      if (isSingleChatRoom(roomId)) {
        // Join the single chat room. The chat room join is not created, yet.
        await ChatRoom.createSingle(getOtherUid(roomId));
        room = await ChatRoom.get(roomId);
      } else {
        // Group chat room must exist before entering chat room.
        throw SuperLibraryException(
            'chat/room-join', 'Group chat room not found');
      }
    } else if (room.joined &&
        room.users.containsKey(myUid) &&
        room.users[myUid] == true) {
      // Already joined and accepted the invitation, then just return.
      return;
    } else {
      // Chat room exists but not joined yet.
    }

    // Hereby, [room] is ready.
    dog("continue the join work for the room now: $room");

    final timestamp = await getDatabaseServerTimestamp();
    final negativeTimestamp = -1 * timestamp;

    // int timestamp = await getDatabaseServerTimestamp();
    // final order = timestamp * -1; // int.parse("-1$timestamp");
    final joinValues = {
      // Add uid in users
      room!.ref.child('users').child(myUid).path: true,

      // Should be in top in order
      // This will make the newly joined room at top.
      'chat/joins/$myUid/${room.id}/${f.order}': negativeTimestamp,
      if (room.single)
        'chat/joins/$myUid/${room.id}/${f.singleOrder}': negativeTimestamp,
      if (room.group)
        'chat/joins/$myUid/${room.id}/${f.groupOrder}': negativeTimestamp,
      if (room.open)
        'chat/joins/$myUid/${room.id}/${f.openOrder}': negativeTimestamp,

      // Chat room information
      if (room.name.isNotEmpty)
        'chat/joins/$myUid/${room.id}/${f.name}': room.name,
      if (room.iconUrl != null)
        'chat/joins/$myUid/${room.id}/${f.iconUrl}': room.iconUrl,
    };
    // If it's single chat, add the other user information to my room's join
    if (room.single == true) {
      final other = await UserData.get(getOtherUid(room.id));
      if (other != null) {
        joinValues.addAll({
          'chat/joins/$myUid/${room.id}/${f.displayName}': other.displayName,
          'chat/joins/$myUid/${room.id}/${f.photoUrl}': other.photoUrl,
        });
      }
    }

    dog("Joining: $joinValues");

    await database.ref().update(joinValues);

    // TODO support protocol
    // await sendMessage(
    //   room,
    // protocol: protocol ?? ChatProtocol.join,
    // );
  }

  /// Invite a user to a chat room
  ///
  /// Only the group chat room can invite a user.
  ///
  /// * Put false in the user's uid in the room.users.
  Future<void> invite({
    required String roomId,
    required String otherUid,
  }) async {
    dog("Inviting into roomId: $roomId, otherUid: $otherUid");
    // Prepare
    const f = ChatJoin.field;
    ChatRoom? room = await ChatRoom.get(roomId);
    if (room == null) {
      throw SuperLibraryException(
          'chat-room-join', 'Group chat room not found');
    }
    UserData my = await UserData.get(myUid) as UserData;

    final timestamp = await getDatabaseServerTimestamp();
    final negativeTimestamp = -1 * timestamp;
    final joinValues = {
      room.ref.child('users').child(otherUid).path: false,

      // Should be in top in order
      // This will make the newly joined room at top.
      'chat/joins/$otherUid/${room.id}/${f.order}': negativeTimestamp,
      if (room.group)
        'chat/joins/$otherUid/${room.id}/${f.groupOrder}': negativeTimestamp,
      if (room.open)
        'chat/joins/$otherUid/${room.id}/${f.openOrder}': negativeTimestamp,

      // Chat room information
      if (room.name.isNotEmpty)
        'chat/joins/$otherUid/${room.id}/${f.name}': room.name,

      // Add the inviter's information
      'chat/joins/$otherUid/${room.id}/${f.inviterUid}': my.uid,
      'chat/joins/$otherUid/${room.id}/${f.inviterName}': my.displayName,
    };
    dog("Inviting: $joinValues");
    await database.ref().update(joinValues);
  }

  /// Adjust chat data upon entering the chat room
  ///
  /// [roomId] may be a user uid or may be the chat room id.
  Future<void> enter(String roomId) async {
    dog("Entering into roomId: $roomId");
    // Check if the user is blocked by login user
    if (UserService.instance.hasBlocked(otherUidOrRoomId(roomId))) {
      throw SuperLibraryException('chat/enter', 'User is blocked');
    }

    const f = ChatJoin.field;

    // Using get() is having problem, because sometimes it is getting the
    // whole node (along with the other children or fields). For now, using
    // once().
    // Related issues:
    // https://github.com/firebase/flutterfire/issues/10145
    // https://github.com/firebase/firebase-ios-sdk/issues/12225
    // https://github.com/firebase/firebase-ios-sdk/issues/12965
    final lastMessageAt =
        await database.ref('chat/rooms/$roomId/lastMessageAt').once();
    final updatedOrder = -1 * ((lastMessageAt.snapshot.value ?? 0) as int);

    final enterValues = {
      // TODO: Don't update if these fields are not existing for the performance improvement.
      'chat/joins/$myUid/$roomId/${f.inviterUid}': null,
      'chat/joins/$myUid/$roomId/${f.inviterName}': null,

      // Remove the no of new messages in each chat room and in the settings
      'chat/settings/$myUid/${f.newMessageCount}/$roomId': null,
      'chat/joins/$myUid/$roomId/${f.newMessageCount}': null,

      // Reorder because it has been read.
      'chat/joins/$myUid/$roomId/order': updatedOrder,

      if (isSingleChatRoom(roomId))
        'chat/joins/$myUid/$roomId/${f.singleOrder}': updatedOrder,
      if (!isSingleChatRoom(roomId))
        'chat/joins/$myUid/$roomId/${f.groupOrder}': updatedOrder,
      // TODO how can we reorder the open chats
      // 'chat/joins/$myUid/$roomId/${f.openOrder}': updatedOrder,
    };
    await database.ref().update(enterValues);
  }

  /// [uidOrRoomId] may be a user uid. It can be the chat room id.
  ///
  ///
  /// Logic:
  /// - Delete the user's uid from the room.users.
  /// - Delete the chat join data of the user.
  Future<void> leave(String uidOrRoomId) async {
    // Add your function code here!
    final roomId = convertIfUidToSingleChatRoomId(uidOrRoomId);

    await joinsRef.child(roomId).remove();
    await roomRef(roomId).child('users').child(myUid).remove();
  }
}

class Comment {
  DatabaseReference get commentsRef => CommentService.instance.commentsRef;
  DatabaseReference commentRef(String key) =>
      CommentService.instance.commentRef(key);

  /// [key] is the key of the comment data node.
  final String key;

  /// Change on Oct 26, 2024 - To reduce the confusion, the it only supports
  /// the comments of the data. If you want to use it for the comments for the
  /// user, photo, or any other node, you must use the user's UID or photo key
  /// as the rootKey. And in the case of using the comments for non-data node,
  /// the commentCount field will be added to the node of /data/<uid> or
  /// /data/<photoKey> . So, the app may get the commentCount from the
  /// /data/<uid>/commentCount or /data/<photoKey>/commentCount.
  ///
  /// [rootKey] is the key of the root node of the comment.
  final String rootKey;
  final String? parentKey;
  final String content;
  final String uid;
  final int createdAt;
  final int updatedAt;
  final List<String> urls;
  final int depth;
  final String order;
  final bool deleted;
  final int likeCount;

  ///
  bool hasChild = false;

  /// Returns true if the comment belongs to the current user.
  bool get isMine => uid == currentUserUid;

  DatabaseReference get ref => commentRef(key);

  Comment({
    required this.key,
    required this.rootKey,
    required this.parentKey,
    required this.content,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
    required this.urls,
    required this.depth,
    required this.order,
    required this.deleted,
    required this.likeCount,
  });

  static const field = (
    key: 'key',
    rootKey: 'rootKey',
    parentKey: 'parentKey',
    content: 'content',
    uid: 'uid',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    urls: 'urls',
    depth: 'depth',
    order: 'order',
    deleted: 'deleted',
    commentCount: 'commentCount',
    likeCount: 'likeCount',
    isMine: 'isMine',
    path: 'path',
  );

  factory Comment.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.exists == false) {
      throw 'comment-modeling/comment-not-exist Comment does not exist';
    }

    final docSnapshot = snapshot.value as Map;
    return Comment.fromJson(docSnapshot, snapshot.key!);
  }

  factory Comment.fromJson(Map<dynamic, dynamic> json, String key) {
    return Comment(
      key: key,
      rootKey: json[field.rootKey],
      parentKey: json[field.parentKey],
      content: json[field.content] ?? '',
      uid: json[field.uid],
      createdAt: json[field.createdAt] ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: json[field.updatedAt] ?? DateTime.now().millisecondsSinceEpoch,
      urls: List<String>.from(json[field.urls] ?? []),
      depth: json[field.depth] ?? 0,
      order: json[field.order],
      deleted: json[field.deleted] ?? false,
      likeCount: json[field.likeCount] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      field.key: key,
      field.rootKey: rootKey,
      field.parentKey: parentKey,
      field.content: content,
      field.uid: uid,
      field.createdAt: createdAt,
      field.updatedAt: updatedAt,
      field.urls: urls,
      field.depth: depth,
      field.order: order,
      field.deleted: deleted,
      field.isMine: isMine,
      field.path: ref.path,
      field.likeCount: likeCount,
    };
  }

  @override
  String toString() {
    return 'Comment(${toJson()})';
  }

  /// [create] creates a new comment.
  /// Returns the database reference of the comment.
  ///
  ///
  ///
  ///
  /// [parentKey] is the parentKey of the comment.
  static Future<DatabaseReference> create({
    required String rootKey,
    String? parentKey,
    String? content,
    List<String>? urls,
  }) async {
    /// Get the commentCount of the root.
    /// * Note that, if the root does not exist, it will create the root node.
    /// * with the [commentCont] field only.

    final snapshot = await dataRef(rootKey).child('commentCount').get();
    int commentCount = snapshot.value as int? ?? 0;

    /// Get parent comment to get the depth and order.
    int depth = 0;
    String parentOrder = '';
    if (parentKey != null) {
      final parent = await read(parentKey);
      depth = (parent?.depth ?? 0);
      parentOrder = parent?.order ?? '';
    }

    final order = CommentService.instance.getCommentOrderString(
      depth: depth,
      noOfComments: commentCount,
      sortString: parentOrder.isEmpty ? '' : parentOrder.split(':')[1],
    );

    final ref = CommentService.instance.commentsRef.push();

    final comment = {
      field.rootKey: rootKey,
      field.parentKey: parentKey,
      field.content: content,
      field.urls: urls,
      field.createdAt: ServerValue.timestamp,
      field.uid: myUid,
      field.order: '$rootKey:$order',
      field.depth: (depth + 1),
    };

    print('comment path: ${ref.path}');
    dog('comment: $comment');

    await ref.set(comment);

    dog('data path: ${dataRef(rootKey).path}');

    /// Increment the comment count of the root.
    await dataRef(rootKey).update({
      field.commentCount: ServerValue.increment(1),
    });

    return ref;
  }

  /// [read] gets the comment of the comment key
  static Future<Comment?> read(String commentKey) async {
    final snapshot = await CommentService.instance.commentRef(commentKey).get();
    if (!snapshot.exists) {
      return null;
    }
    return Comment.fromSnapshot(snapshot);
  }

  /// [update] updates the comment of the comment key
  ///
  /// To delete [content], pass an empty string.
  /// To delete [urls], pass an empty list.
  Future update({
    String? content,
    List<String>? urls,
  }) async {
    // TODO: check if the comment blongs to the current user
    // TODO: check if the comment is deleted
    await CommentService.instance.commentsRef.child(key).update({
      if (content != null) field.content: content,
      if (urls != null) field.urls: urls,
      field.updatedAt: ServerValue.timestamp,
    });
  }

  static Future updateByKey({
    required String commentKey,
    String? content,
    List<String>? urls,
  }) async {
    final comment = await read(commentKey);
    // TODO: check if the comment exists or null
    await comment?.update(
      content: content,
      urls: urls,
    );
  }

  /// [delete] deletes the comment of the comment key
  Future delete() async {
    // TODO: check if the comment blongs to the current user
    // TODO: check if the comment is deleted

    for (String url in urls) {
      await StorageService.instance.delete(url);
    }

    // await ref.remove();
    await ref.update({
      field.content: 'Deleted',
      field.urls: [],
      field.deleted: true,
      field.updatedAt: ServerValue.timestamp,
    });
  }

  /// [deleteByKey] is a method to delete the data from the database by the key.
  static Future<void> deleteByKey(String commentKey) async {
    final comment = await read(commentKey);
    if (comment == null) {
      throw 'comment-delete/comment-not-exist Comment does not exist';
    }
    await comment.delete();
  }
}

class CommentService {
  static CommentService? _instance;
  static CommentService get instance => _instance ??= CommentService._();
  CommentService._();

  DatabaseReference get commentsRef => database.ref().child('comments');
  DatabaseReference commentRef(String key) => commentsRef.child(key);

  /// Get the parents of the comment under a root.
  ///
  /// It returns the list of parents in the path to the root from the comment.
  /// Use this method to get
  ///   - the parents of the comment.
  ///     (This is the case used by sorting comments and drawing the comment tree)
  ///   - the users(user uid) in the path to the root.
  ///     (To get the UIDs of the comment authors in the path to the data to send push notification)
  List<Comment> getParents(Comment comment, List<Comment> comments) {
    final List<Comment> parents = [];
    Comment? parent = comment;
    while (parent != null) {
      parent = comments.firstWhereOrNull(
        (e) => e.key == parent!.key,
      );
      if (parent != null) {
        parents.add(parent);
      }
    }
    return parents.reversed.toList();
  }

  /// getCommentOrderString
  ///
  /// Firebase Firestore Database 에서 코멘트의 정렬을 위한 문자열을 생성한다. 코멘트는
  /// 글에 대한 코멘트이며, 글에 대한 코멘트는 글의 noOfComments 값을 가지고 있다.
  ///
  /// 코멘트의 단계에서 형제 코멘트가 하나 생성 될 때, sortString 의 블록 값이 1씩 증가한다.
  ///
  /// 맨 첫 번째 코멘트란, 글에 최초로 작성되는 코멘트. 1번째 코멘트. 해당 글에 하나 뿐이다.
  /// 첫번째 레벨 코멘트란, 글 바로 아래에 작성되는 코멘트로, 부모 코멘트가 없는 코멘트이다. 이 경우 depth=0 이다.
  ///
  /// [noOfComments] 는 글의 noOfComments 를 그대로 입력하면 된다.
  /// 참고, 맨 첫번째 코멘트를 작성할 때는 noOfComments 값을 그냥 0의 값(또는 NULL)을 입력하면 된다.
  ///
  /// [sortString] 는 부모 코멘트의 sortString 을 그 대로 입력하면 된다. 첫번째 레벨 코멘트의 경우, 빈 NULL (또는 빈문자열)을 입력하면 된다.
  ///
  /// [depth] 는 부모 코멘트의 depth 값 그대로 들어와야 한다.
  /// 부모 코멘트의 depth 가 3 이면, 3 로 입력되어야 한다. (3 + 1 로 입력하면 안된다.)
  /// `first level comments` 의 경우, 입력되는 [sortString] 값이 null 또는 빈 문자열이다. 이 경우,
  /// [depth] 값은 무시되고, 첫번재 블록에 noOfComments 값을 입력한다.
  ///
  /// DB 에 저장 할 때에는 [depth] 값이 1부터 시작된다. 즉, `first level comemnts` 의 depth 는 1인 것이다.
  /// 그리고 중요한 것은, 저장 할 때에는 부모 depth 에서 1 증가된 값으로 저장하면 된다. 예를 들어, first level comment 는 1을 저장하고,
  /// 그 아래 부터는 +1을 해서 저장하면 된다.
  ///
  ///
  ///
  String getCommentOrderString({
    required int depth,
    int? noOfComments,
    String? sortString,
  }) {
    /// [maxDepth] 코멘트 레벨 최대 깊이
    const int maxDepth = 9;
    noOfComments ??= 0;
    sortString ??= "";
    if (sortString.isEmpty) {
      /// 첫번째 블록을 +1 하는 것이 아니라, DB 액세스를 줄이고자, noOfComments 값을 사용한다.
      final String firstPart = noOfComments.toString().padLeft(6, '0');
      return '$firstPart.000000.000000.000000.000000.000000.000000.000000.000000.000000';
    } else {
      /// maxDepth 보다 depth 가 크면, maxDepth - 1 로 설정해서, 맨 마지막 블록을 증가시킨다.
      /// 즉, max depth 를 제한한다.
      if (depth >= maxDepth) depth = maxDepth - 1;

      List<String> parts = sortString.split('.');

      /// 블록에서, 1씩 증가하는 것이 아니라, noOfComments 값으로 증가한다.
      /// 이 문제를 해결 하기 위해서는 이전 (형제) 코멘트를 한번 더 DB 에서 읽어야하는 상황이 발생해서,
      /// DB 액세스를 줄이고자, noOfComments 값을 사용한다.
      int blockValue = int.parse(parts[depth]);
      blockValue = noOfComments;
      parts[depth] = blockValue.toString().padLeft(6, '0');

      /// 아래의 코드는 굳이 필요 없지만, 혹시 모르니 남겨 둔다.
      for (int i = depth + 1; i < maxDepth; i++) {
        parts[i] = '000000'; // 하위 depth를 초기화
      }

      return parts.join('.');
    }
  }
}

/// Confirm dialog
///
/// It requires build context.
///
/// Return true if the user taps on the 'Yes' button.
///
/// TODO: support custom design.
Future<bool?> confirm({
  required BuildContext context,
  required Widget title,
  Widget? subtitle,
  required Widget message,
}) {
  return
      //  HouseService.instance.confirmDialog
      //         ?.call(context: context, title: title, message: message) ??
      showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return ConfirmDialog(
        title: title,
        subtitle: subtitle,
        message: message,
      );
    },
  );
}

/// Confirm dialog widget
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    this.subtitle,
    required this.message,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (subtitle != null) ...[
            subtitle!,
            const SizedBox(height: 24),
          ],
          message,
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('no'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('yes'),
        ),
      ],
    );
  }
}

/// Component holder class.
/// Note that, the comopoent is not used in this library due to the widget builder
// class Component {
//   static Widget Function(UserData)? userListTile;
//   static Widget Function(ChatJoin)? chatRoomListTile;
//   static Widget Function(ChatRoom)? openChatRoomListTile;
//   static Widget Function(ChatMessage)? chatMessageListTile;

//   /// dataListTile is for displaying data in the DataListView.
//   static Widget Function(Data)? dataListTile;
// }

/// User references --------------------------------------------------------------------------------
/// Database reference for the user with [uid]
@Deprecated('Use [Ref.user] instead')
DatabaseReference databaseUserRef(String uid) {
  return UserService.instance.databaseUserRef(uid);
}

/// Print log message with emoji 🐶
void dog(dynamic msg, {int level = 0}) {
  if (kReleaseMode) return;
  if (SuperLibrary.instance.debugLog == false) return;
  log('--> ${msg.toString()}', time: DateTime.now(), name: '🐶', level: level);
}

String? getSitePreviewMeta(Document document, String parameter) {
  final metaTags = document.getElementsByTagName("meta");
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    if (meta.attributes['name'] == parameter) {
      return meta.attributes['content']?.replaceAll('\n', " ");
    }
  }
  return null;
}

String? getSitePreviewOGTag(Document document, String parameter) {
  final metaTags = document.getElementsByTagName("meta");
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    if (meta.attributes['property'] == parameter) {
      return meta.attributes['content']?.replaceAll('\n', " ");
    }
  }
  return null;
}

String? getSitePreviewTag(Document document, String tag) {
  final metaTags = document.getElementsByTagName(tag);
  if (metaTags.isEmpty) return null;
  for (var meta in metaTags) {
    return meta.text.replaceAll('\n', " ");
  }
  return null;
}

/// load site preview from the url
///
/// [text] is a text that contains the url.
///
/// It throws exception if it fails to get the site preview.
///
/// It returns null if it fails to get the site preview.
///
/// It returns the site preview data if it successfully gets the site preview.
/// But the fields might be null if the site preview data is not found.
Future<SitePreviewData?> loadSitePreview({
  required String text,
}) async {
  // Get the first url of in the text
  final RegExp urlRegex = RegExp(r'https?:\/\/\S+');
  final Match? match = urlRegex.firstMatch(text);
  final String? url = match?.group(0);
  if (url == null) {
    return null;
  }

  // Get the data from the url (internet)
  final dio = Dio();
  Response response;
  try {
    response = await dio.get(url);
  } catch (e) {
    dog('dio.get($url) Error: $e');
    throw SuperLibraryException(
        'load-site-preview/get-failed', 'Failed to get the site preview: $e');
  }
  dynamic res = response.data;
  if (res == null) {
    throw SuperLibraryException('load-site-preview/response-is-empty',
        'Result from dio.get($url) is null');
  }
  String html = res.toString();

  final Document doc = parse(html);

  String? title =
      getSitePreviewOGTag(doc, 'og:title') ?? getSitePreviewTag(doc, 'title');
  String? description = getSitePreviewOGTag(doc, 'og:description') ??
      getSitePreviewMeta(doc, 'description');
  String? imageUrl = getSitePreviewOGTag(doc, 'og:image');
  String? siteName = getSitePreviewOGTag(doc, 'og:site_name') ??
      getSitePreviewTag(doc, 'title');

  return SitePreviewData(
    url: url,
    title: title,
    description: description,
    imageUrl: imageUrl,
    siteName: siteName,
  );
}

/// Return true if the chat room is a single chat room.
bool isSingleChatRoom(roomId) => ChatService.instance.isSingleChatRoom(roomId);

/// [Data] class is a data modeling class of the `/data` node in the Realtime
/// database.
///
/// It is not only including the data modeling but also the basic CRUD like
/// read, write. Anything else than the data modeling and basic CRUD should be
/// in the [DataService] class.
class Data {
  String key;
  String uid;
  int createdAt;
  int updatedAt;
  bool deleted;
  String category;
  String title;
  String content;
  List<String> urls;
  int likeCount;

  /// [data] holds the JSON data of the data node. This hold the data itself.
  Map<dynamic, dynamic> data;

  Data({
    required this.key,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
    required this.deleted,
    required this.category,
    required this.title,
    required this.content,
    required this.urls,
    required this.data,
    required this.likeCount,
  });

  DatabaseReference get ref => Ref.data.child(key);

  bool get isMine => uid == currentUserUid;

  /// Field names used for the Firestore document
  static const field = (
    key: 'key',
    uid: 'uid',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    deleted: 'deleted',
    category: 'category',
    title: 'title',
    content: 'content',
    urls: 'urls',
    likeCount: 'likeCount',
    isMine: 'isMine',
    path: 'path',
  );

  /// [value] is a method to get the value from the data.
  ///
  /// It returns the value of the key. If the key does not exist, it returns
  /// the [defaultValue]. It is safer to use this method to get the value from
  /// the data.
  ///
  /// Example:
  /// ```dart
  /// assert(updatedData.data['extra'] == 'v1'); // If you are sure, you can access [data] directly.
  /// assert(updatedData.value('extra', '') == 'v1'); // If you are not sure, you can use [value] method.
  /// ```
  T value<T>(String key, T defaultValue) {
    if (data[key] == null) {
      return defaultValue;
    }
    return data[key] as T;
  }

  toJson() => {
        ...data,
        field.isMine:
            currentUserUid != null && data[field.uid] == currentUserUid,
        field.path: ref.path,
        field.likeCount: likeCount,
        field.deleted: deleted,
      };

  @override
  String toString() => "Data(key: $key, $data)";

  factory Data.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map<dynamic, dynamic>;
    return Data.fromJson(data, snapshot.key!);
  }

  factory Data.fromJson(Map<dynamic, dynamic> data, String key) {
    return Data(
      key: key,
      uid: data[field.uid] as String,
      createdAt: data[field.createdAt] ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: data[field.updatedAt] ?? DateTime.now().millisecondsSinceEpoch,
      deleted: data[field.deleted] ?? false,
      category: data[field.category] as String,
      title: data[field.title] ?? '',
      content: data[field.content] ?? '',
      urls: List<String>.from(data[field.urls] ?? []),
      data: {
        ...data,
        field.key: key,
        field.path: Ref.data.child(key).path,
      },
      likeCount: data[field.likeCount] ?? 0,
    );
  }

  /// [create] is a method to create the data in the database.
  ///
  /// Returns the reference of the data
  static Future<DatabaseReference> create({
    required String category,
    String? title,
    String? content,
    List<String>? urls,
    Map<dynamic, dynamic>? data,
  }) async {
    data ??= {};
    data[field.category] = category;
    data[field.uid] = myUid;
    data[field.createdAt] = ServerValue.timestamp;
    data[field.updatedAt] = ServerValue.timestamp;
    if (title != null) data[field.title] = title;
    if (content != null) data[field.content] = content;
    if (urls != null) data[field.urls] = urls;

    DatabaseReference ref = Ref.data.push();

    dog('Data.create() at: ${ref.path} with: $data');
    await ref.set(data);

    return ref;
  }

  /// [update] is a method to update the data in the database.
  Future<void> update({
    String? category,
    String? title,
    String? content,
    List<String>? urls,
    Map<String, dynamic>? data,
  }) async {
    // data ??= {};

    // //
    // data[field.updatedAt] = ServerValue.timestamp;

    // if (category != null) data[field.category] = category;
    // if (title != null) data[field.title] = title;
    // if (content != null) data[field.content] = content;
    // if (urls != null) data[field.urls] = urls;

    // // dog('Data.update() at: ${ref.path} with: $data');
    // await ref.update(data);

    ///
    await updateByKey(key, category, title, content, urls, data);
  }

  /// [deleteByKey] is a method to delete the data from the database by the key.
  static Future<void> updateByKey(
    String key,
    String? category,
    String? title,
    String? content,
    List<String>? urls,
    Map<String, dynamic>? data,
  ) async {
    data ??= {};
    data[field.updatedAt] = ServerValue.timestamp;

    if (category != null) data[field.category] = category;
    if (title != null) data[field.title] = title;
    if (content != null) data[field.content] = content;
    if (urls != null) data[field.urls] = urls;

    // dog('Data.update() at: ${ref.path} with: $data');
    await Ref.data.child(key).update(data);
  }

  /// [read] is a method to read the data from the database.
  static Future<Data> read(String key) async {
    final snapshot = await Ref.data.child(key).get();
    if (snapshot.exists == false) {
      throw SuperLibraryException('data/read', 'Data not found');
    }

    return Data.fromSnapshot(snapshot);
  }

  /// [readField] is a method to read the specific field of data from the database.
  static Future<dynamic> readField(String key, String field) async {
    final snapshot = await Ref.data.child(key).child(field).get();
    if (snapshot.exists == false) {
      return null;
    }
    return snapshot.value;
  }

  /// [delete] is a method to delete the data from the database.
  ///
  /// It does not actually delete the data. It just sets the [deleted] field to
  /// true and sets empty to the [title] and [content],[urls] fields.
  Future<void> delete() async {
    dog('Data.delete() at: ${ref.path}');

    for (String url in urls) {
      await StorageService.instance.delete(url);
    }

    await ref.update({
      field.title: 'Deleted',
      field.content: 'Deleted',
      field.urls: [],
      field.deleted: true,
      field.updatedAt: ServerValue.timestamp,
    });
  }

  /// [deleteByKey] is a method to delete the data from the database by the key.
  static Future<void> deleteByKey(String key) async {
    final data = await read(key);
    await data.delete();
  }
}

/// [DataService] is a service class that provides anything else than the data
/// modeling and basic CRUD.
class DataService {
  //
}

class FFUser {
  static const String displayName = 'display_name';
  static const String photoURL = 'photo_url';
  static const String createdTime = 'created_time';
}

/// Returns true if the text has a valid uid format.
isUid(String text) {
  if (text.length != 28) return false;
  if (text.startsWith('-')) return false;

  return true;
}

/// Like
///
/// - If a user liked an object(user, post, comment or anything) or not.
///   uid-path: uid-stamp, null.
/// - How many likes the object has.
class Like {
  final String path;
  DatabaseReference get objectRef => database.ref(path);

  Like({
    required this.path,
  });

  static const field = (likeCount: 'likeCount');

  static Future<bool> like(String path) async {
    if (currentUserUid == null) {
      throw SuperLibraryException(
          'like/sign-in-required', 'User is not signed in');
    }

    DatabaseReference objectRef = database.ref(path);
    DatabaseReference likeRef = LikeService.instance.likeRef(path);
    final snapshot = await likeRef.get();

    final hasLiked = snapshot.exists;

    final String likeValue =
        myUid + DateTime.now().millisecondsSinceEpoch.toString();
    await database.ref().update({
      likeRef.path: hasLiked ? null : likeValue,
      '${objectRef.path}/${field.likeCount}':
          hasLiked ? ServerValue.increment(-1) : ServerValue.increment(1),
    });
    final like = await likeRef.get();
    return like.exists;
  }
}

class LikeService {
  static LikeService? _instance;
  static LikeService get instance => _instance ??= LikeService._();
  LikeService._();

  DatabaseReference get likesRef => database.ref('likes');
  DatabaseReference likeRef(String path) =>
      likesRef.child('$myUid-${path.replaceAll('/', '-')}');
}

/// Memory
///
/// A static memory class to store data in memory
///
/// Note that any data that might be re-used must be stored in the memory (like
/// user data, chat room data, etc) with this Memeory class to not fetch the
/// data again and again. And this will help to reduce flickering and improve
/// the performance.
///
/// Usage:
/// ```dart
/// Memory.set('key', 'value);
/// final value = Memory.get<String>('key');
/// ```
class Memory {
  static final Map<String, dynamic> _data = {};

  static T? get<T>(String key) => _data[key] as T?;

  static void set<T>(String key, T value) {
    _data[key] = value;
  }
}

/// Re-build the widget if my document in Firestore changes;
///
/// Not that this widget does not listen to the user's document `/users/<uid>`.
/// It listens to the [UserService.instance.changes]. There is no extra access
/// to the Firestore.
///
/// If the user's document in Firestore changes, [UserService.instance.changes]
/// will be triggered. And this widget will be re-built.
///
/// It is useful to re-build the widget if the user's document in Firestore changes.
///
/// If the user didn't login, or is in the middle of logging in, or the user's
/// document does not exist, the [User] in the builder parameter can be null.
///
/// If the user logs out or changes the account, the [User] in the builder
/// parameter will be null.
///
/// To reduce the flickering, it uses the initialData from the
/// [UserService.instance.firestoreUserData].
///
///
/// Use this widget to display widgets that depends on user's login status.
/// For example, if the user is logged in, it shows the user's profile. If the
/// user is not logged in, it shows the login button.
class MyDoc extends StatelessWidget {
  const MyDoc({super.key, required this.builder});
  final Widget Function(Map<String, dynamic>?) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>?>(
      initialData: UserService.instance.firestoreUserData,
      stream: UserService.instance.changes,
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.hasData == false) {
          return const SizedBox.shrink();
        }
        // dog('MyDoc() snapshot.data: ${snapshot.data}, ${snapshot.data?.length}, $currentUserUid');
        return builder(
            (snapshot.data ?? {}).isEmpty == true ? null : snapshot.data);
      },
    );
  }
}

/// Return the other user's uid from the single chat room id.
///
/// * If it's not the single chat room id, it throws exception;
String otherUid(roomId) => ChatService.instance.getOtherUid(roomId);

/// Returns other user's uid if it's single chat room. If the input roomId is
/// not single chat room, it returns the same input string.
///
/// [roomId] may be a user uid, chat room id, or single chat room id.
///
/// If it's not single chat room, it returns the same input string which may be
/// a user uid or chat room id.
///
/// * The difference between [otherUid] and [otherUidOrRoomId] is that
/// [otherUidOrRoomId] does not throw exception if the input roomId is not a
/// single chat room id.
String otherUidOrRoomId(roomId) {
  if (isSingleChatRoom(roomId)) {
    return otherUid(roomId);
  } else {
    return roomId;
  }
}

/// [Ref] class has the Realtime Database references
class Ref {
  static DatabaseReference user(String uid) =>
      UserService.instance.databaseUserRef(uid);
  static userPhotoUrl(String uid) => user(uid).child(UserData.field.photoUrl);
  static DatabaseReference get my => user(myUid);

  static DatabaseReference get data => database.ref('data');
  // Returns the chat room reference.
  static DatabaseReference room(String roomId) =>
      ChatService.instance.roomRef(roomId);
}

class Report {
  final String id;
  final String reporter;
  final String reportee;
  final String path;
  final String reason;
  final String type;
  final String summary;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.reporter,
    required this.reportee,
    required this.path,
    required this.reason,
    required this.type,
    required this.summary,
    required this.createdAt,
  });

  static fs.CollectionReference get col => firestore.collection('reports');

  factory Report.fromSnapshot(DataSnapshot snapshot) {
    return Report.fromJson(
      Map<String, dynamic>.from(snapshot.value as Map),
      snapshot.key!,
    );
  }

  factory Report.fromJson(Map<String, dynamic> json, String id) {
    return Report(
      id: id,
      reporter: json['reporter'] ?? '',
      reportee: json['reportee'] ?? '',
      path: json['path'] ?? '',
      reason: json['reason'] ?? '',
      type: json['type'] ?? '',
      summary: json['summary'] ?? '',
      createdAt: json['createdAt'] != null && json['createdAt'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reporter': reporter,
      'reportee': reportee,
      'path': path,
      'reason': reason,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Report(${toJson()})';
  }
}

/// [roomRef] returns the chat room reference.
DatabaseReference roomRef(String roomId) => Ref.room(roomId);

/// [SitePreview] is a widget to show the preview of the site.
class SitePreview extends StatelessWidget {
  const SitePreview({
    super.key,
    required this.data,
    this.maxLinesOfDescription = 3,
  });

  final SitePreviewData data;
  final int maxLinesOfDescription;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (data.url == null) {
          return;
        }
        // if (await canLaunchUrlString(data.url!)) {
        //   await launchUrlString(data.url!);
        // } else {
        //   throw 'Could not launch {$data.url}';
        // }
        if (data.url == null) {
          return;
        }
        var uri = Uri.parse(data.url!);
        try {
          await launchUrl(uri);
        } catch (e) {
          throw 'Could not launch $uri: $e';
        }
      },
      child: Container(
        /// [imageUrl] are sometimes smaller than the length of the [description] and leads to
        /// inconsistent design of the [UrlPreview] in [ChatViewScreen] and [ForumChatViewScreen]
        /// [BoxConstraints] to make it a single width and consistent design

        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.imageUrl != null && data.imageUrl!.isNotEmpty) ...[
              CachedNetworkImage(
                imageUrl: data.imageUrl!,
                // Don't show
                errorWidget: (context, url, error) {
                  dog("Not showing an image preview because there's a problem with the url: ${data.imageUrl}");
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 8),
            ],
            if (data.title != null && data.title!.isNotEmpty) ...[
              Text(
                data.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (data.description != null && data.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                data.description!.length > 100
                    ? '${data.description!.substring(0, 90)}...'
                    : data.description!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                maxLines: maxLinesOfDescription,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SitePreviewData {
  final String? url;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? siteName;

  SitePreviewData({
    this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.siteName,
  });
}

class StorageService {
  static StorageService? _instance;
  static StorageService get instance => _instance ??= StorageService._();

  ///
  StorageService._();

  /// Delete the uploaded file from Firebase Storage by the url.
  ///
  /// If the url is null or empty, it does nothing.
  ///
  /// If the [ref] is set, it will delete the field when the url is deleted.
  ///
  /// When the file does not exist in Firebsae Stroage,
  /// - If the [ref] is null, it will simply returns without firing exception.
  /// - If the [ref] is set, it will delete the field in the document.
  ///
  /// You can use this method especially when the file of the url in Storage is
  /// deleted already (or not exist). It will not throw an exception and you
  /// can continue the logic.
  Future<void> delete(
    String? url, {
    DatabaseReference? ref,
  }) async {
    if (url == null || url == '') return;
    final storageRef = FirebaseStorage.instance.refFromURL(url);
    try {
      await storageRef.delete();
    } on FirebaseException catch (e) {
      /// Oops! The file does not exist in the Firebase Storage.
      if (e.code == 'object-not-found') {
        if (ref == null) {
          /// Return as if the file is deleted.
          return;
        }
      } else {
        log('Error deleting file on catch(FirebaseException): $url');
        log(e.toString());
        rethrow;
      }
    } catch (e) {
      log('Error deleting file on catch(e): $url');
      log(e.toString());
    }

    if (ref != null) {
      await ref.remove();
    }
  }
}

class SuperLibrary {
  static SuperLibrary? _instance;
  static SuperLibrary get instance => _instance ??= SuperLibrary._();

  SuperLibrary._();

  String? databaseURL;
  FirebaseDatabase? _database;

  bool initialized = false;

  bool debugLog = false;

  /// Returns the firebase database
  ///
  /// * It is important to use this method to get the database reference.
  /// * Do not use `FirebaseDatabase.instance` directly.
  ///
  /// If it's web, then it requires the databaseURL.
  ///
  /// For mobile app, the databaseURL is automatically set in the google
  /// service files by the FlutterFlow framework.
  FirebaseDatabase get database {
    if (kIsWeb) {
      databaseURL ??= FFLibraryValues().databaseURL;
      if (databaseURL == null) {
        throw Exception('SuperLibrary.databaseURL is null');
      }

      _database ??= FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL: databaseURL,
      );

      return _database!;
    }
    return FirebaseDatabase.instance;
  }
}

extension SuperLibraryIntExtension on int {
  /// Change the integer of milliseconds to a DateTime object
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
}

class SuperLibraryException implements Exception {
  final String code;
  final String message;

  SuperLibraryException(
    this.code,
    this.message,
  );

  @override
  String toString() {
    return 'SuperLibraryException: ($code) $message';
  }
}

/// String Extension to check if a string is null or empty
///
/// Checks if a String? is null or not in the extends clause.
extension SuperLibraryNullableStringExtension on String? {
  /// Returns true if the string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// If the string is null or empty, then it will return the newString
  String or(String newString) => isNullOrEmpty ? newString : this!;
}

extension SuperLibraryStringExtension on String {
  /// If the string is empty, return the newString.
  ///
  /// example
  /// ```dart
  /// String gender = user.gender.or(null);
  /// ```
  String or(String newString) => isEmpty ? newString : this;

  /// Cut the string
  ///
  /// [suffix] is the string to be added at the end of the string. You may want
  /// to add '...' at the end of the string.
  ///
  /// ```dart
  /// Text( comment.content.cut(56, suffix: '...') );
  /// ```
  String cut(int length, {String suffix = ''}) {
    String temp = this;
    temp = temp.trim();
    temp = temp.replaceAll('\n', ' ');
    temp = temp.replaceAll('\r', ' ');
    temp = temp.replaceAll('\t', ' ');
    return temp.length > length ? '${temp.substring(0, length)}$suffix' : temp;
  }
}

/// User Data
///
/// This is a user data modeling class for Realtime Database. This model does
/// not represent the user data in the Firestore.
///
/// All the member variables and methods in this class are only related to the
/// Realtime Database.
class UserData {
  ///
  /// Field names used for the Firestore document
  static const field = (
    uid: 'uid',
    createdAt: 'createdAt',
    displayName: 'displayName',
    displayNameLowerCase: 'displayNameLowerCase',
    photoUrl: 'photoUrl',
  );

  final String uid;
  final int createdAt;
  final String displayName;
  final String displayNameLowerCase;
  final String photoUrl;

  UserData({
    required this.uid,
    required this.createdAt,
    required this.displayName,
    required this.displayNameLowerCase,
    required this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      field.uid: uid,
      field.createdAt: createdAt,
      field.displayName: displayName,
      field.displayNameLowerCase: displayNameLowerCase,
      field.photoUrl: photoUrl,
    };
  }

  @override
  String toString() {
    return 'UserData(${toJson()})';
  }

  /// Returns the user data from the json as UserData model
  ///
  /// * Warning: This method caches the user data in the memory automatically.
  /// * So, you would use `UserData.get(cache: false)` method to get the user data
  /// * from the database without caching.
  factory UserData.fromJson(Map<dynamic, dynamic> json, String key) {
    final userData = UserData(
      uid: key,
      createdAt: json[field.createdAt] ?? DateTime.now().millisecondsSinceEpoch,
      displayName: json[field.displayName] ?? '',
      displayNameLowerCase: json[field.displayNameLowerCase] ?? '',
      photoUrl: json[field.photoUrl] ?? '',
    );

    Memory.set(key, userData);

    return userData;
  }

  factory UserData.fromSnapshot(DataSnapshot snapshot) {
    return UserData.fromJson(snapshot.value as Map, snapshot.key!);
  }

  /// Returns the user data from the Realtime database as UserData model
  ///
  /// This method is used to get the user data from the Realtime database.
  ///
  /// The user data is cached in the memory to reduce the flickering and improve
  /// the performance.
  ///
  /// Returns null if the user data does not exist.
  ///
  /// TODO: make [getValueFromFirestoreMemoryUserData] custom action based on this method.
  static Future<UserData?> get(
    String uid, {
    bool cache = true,
  }) async {
    if (cache && Memory.get(uid) != null) {
      return Memory.get(uid) as UserData;
    }

    final snapshot = await UserService.instance.databaseUserRef(uid).get();
    if (snapshot.exists == false) {
      return null;
    }

    if (snapshot.value == null) {
      return null;
    }

    return UserData.fromSnapshot(snapshot);
  }
}

/// Returns the user's photo url reference
@Deprecated('Use [Ref.userPhotoUrl] instead')
DatabaseReference userPhotoUrlRef(String uid) =>
    databaseUserRef(uid).child(UserData.field.photoUrl);

/// Database reference for the user of the uid
DatabaseReference userRef(String uid) => Ref.user(uid);

class UserService {
  static UserService? _instance;
  static UserService get instance => _instance ??= UserService._();
  UserService._() {
    dog('UserService._() began to initialize');
    _listenAndMirrorUserData();
    initialized = true;
  }

  /// Firestore collection name for users
  String collectionName = 'users';

  /// Firestore user document data.
  /// It is used to store the user data from the Firestore in realtime.
  /// It includes;
  /// - displayName, photoURL, created_time,
  /// - blockedUsers,
  /// - and other user data.
  Map<String, dynamic> firestoreUserData = {};

  /// Get a value in the firestoreUserData that is the user data from the Firestore document
  ///
  /// Use this method to get the login user data from the Firestore document cached in memeory.
  T getValueFromFirestoreMemoryUserData<T>(String k, T defaultValue) {
    // dog('firestoreUserData: $firestoreUserData');
    if (firestoreUserData.containsKey(k)) {
      return firestoreUserData[k] as T;
    } else {
      return defaultValue;
    }
  }

  /// Short alias for [getValueFromFirestoreMemoryUserData]
  T value<T>(String k, T defaultValue) =>
      getValueFromFirestoreMemoryUserData(k, defaultValue);

  /// Get the blocked users of the current user
  List get blockedUsers => value<List>('blockedUsers', []);
  String? get photoUrl => value<String?>('photoUrl', null);

  bool hasBlocked(String uid) => blockedUsers.contains(uid) == true;

  /// Fires when the user document data in Firestore is changed
  BehaviorSubject<Map<String, dynamic>> changes = BehaviorSubject.seeded({});

  DatabaseReference get databaseUsersRef =>
      database.ref().child(collectionName);

  late final bool initialized;

  /// Firestore document reference for the current user
  fs.DocumentReference get myDoc {
    final user = fa.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myDoc: user is not signed in');
    }
    final ref = doc(user.uid);
    return ref;
  }

  /// User document reference
  ///
  /// It's the Firestore document reference for the user with [uid].
  /// * It's not the Realtime Database reference.
  fs.DocumentReference doc(String uid) {
    final ref = firestore.collection(collectionName).doc(uid);

    // dog('path of ref: ${ref.path}');
    return ref;
  }

  /// Database reference for the current user
  DatabaseReference get myDatabaseRef {
    final user = fa.FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('UserService.myDatabaseRef: user is not signed in');
    }
    final ref = databaseUserRef(user.uid);
    return ref;
  }

  /// Database reference for the user with [uid]
  DatabaseReference databaseUserRef(String uid) {
    final ref = database.ref().child(collectionName).child(uid);

    // dog('path of ref: ${ref.path}');
    return ref;
  }

  /// Database reference for the blocked users of the current user
  DatabaseReference get myBlockedUsersRef {
    final user = fa.FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('UserService.myDoc: user is not signed in');
    }
    return database.ref().child('blocked-users').child(user.uid);
  }

  StreamSubscription<fa.User?>? mirrorSubscription;
  StreamSubscription? userDocumentSubscription;

  /// Mirror user's displayName, photoURL, and created_time only from Firestore
  /// to Database.
  ///
  /// * It also copy the 'display_name` into 'dispaly_name_lowercase' for the
  /// * case-insensitive search.
  ///
  ///
  /// Why?
  /// The super library is using Firebase Realtime Database for chat and other
  /// functionalities. But the user's displayName and photoURL are stored in
  /// Firestore by FlutterFlow.
  _listenAndMirrorUserData() {
    mirrorSubscription?.cancel();
    mirrorSubscription =
        fa.FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        dog('Super library -> _listenAndMirrorUserData() -> User is not signed in. So, return');
        firestoreUserData.clear();
        changes.add({});
        return;
      }

      dog('Super library -> _listenAndMirrorUserData() -> User is signed in. So, mirror the user data');

      userDocumentSubscription?.cancel();
      // ! Warning: careful for recursive call by updating the user document and listening to it.
      userDocumentSubscription = doc(user.uid).snapshots().listen((snapshot) {
        if (snapshot.exists == false) {
          changes.add({});
          return;
        }

        // Get user data
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;

        firestoreUserData = data;
        changes.add(data);

        // Copy the 'display_name' into 'dispaly_name_lowercase' for the
        // case-insensitive search.
        // * careful for recursive update and listen to the user document.
        // * careful that this leads to the [changes] stream to emit twice only
        // * when the user's display_name changes.
        if (data['display_name'] != data['display_name_lowercase']) {
          snapshot.reference.update({
            'display_name_lowercase':
                (data['display_name'] as String).toLowerCase(),
          });
        }

        // Mirror user data to database.
        // If a field does exist in the firestore, then save it as null in the
        // database. So, it will be removed from the database.
        int stamp;
        if (data['created_time'] != null &&
            data['created_time'] is fs.Timestamp) {
          stamp = (data['created_time'] as fs.Timestamp).millisecondsSinceEpoch;
        } else {
          stamp = DateTime.now().millisecondsSinceEpoch;
        }
        Map<String, dynamic> update = <String, dynamic>{
          UserData.field.createdAt: stamp,
          UserData.field.displayName: data['display_name'],
          UserData.field.displayNameLowerCase:
              (data['display_name'] ?? '').toLowerCase(),
          UserData.field.photoUrl: data['photo_url'],
        };

        databaseUserRef(user.uid).update(update);
      });
    });
  }

  /// Update the user's profile data into the Firestore
  ///
  /// The fields are optional.
  /// If the field is null, it will not be updated.
  /// You cannot delete a field using this method.
  ///
  /// It updates the 'updatedAt' field in the Firestore.
  updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    await myDoc.set(
      {
        if (displayName != null) 'display_name': displayName,
        if (photoUrl != null) 'photo_url': photoUrl,
        'updatedAt': fs.FieldValue.serverTimestamp(),
      },
      fs.SetOptions(merge: true),
    );
  }

  /// This is a simple log method. But it makes sure that the user's document
  /// exists in the Firestore.
  ///
  /// So, if you are unsure if the user's document exists in the Firestore, you
  /// can use this method after a user logs in.
  login() async {
    await myDoc.set(
      {
        'loginAt': fs.FieldValue.serverTimestamp(),
      },
      fs.SetOptions(merge: true),
    );
  }
}

class Value<T> extends StatelessWidget {
  const Value({
    super.key,
    required this.ref,
    required this.builder,
    this.initialData,
    this.onLoading,
    this.sync = true,
  });

  final DatabaseReference ref;

  final dynamic initialData;

  /// [dynamic] is the value of the node.
  /// [String] is the path of the node.
  final Widget Function(dynamic value, DatabaseReference ref) builder;
  final Widget? onLoading;

  final bool sync;

  @override
  Widget build(BuildContext context) {
    if (sync) {
      return StreamBuilder<dynamic>(
        initialData: initialData,
        stream: ref.onValue.map((event) {
          return event.snapshot.value;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // log('Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text('Error; path: ${ref.path}, message: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            // log('--> Value() -> Waiting; path: ${ref.path} connectionState: ${snapshot.connectionState}, hasData: ${snapshot.hasData}');
            return onLoading ?? const SizedBox.shrink();
          }

          // value may be null.
          return builder(snapshot.data as T, ref);
        },
      );
    } else {
      return FutureBuilder<dynamic>(
        initialData: initialData,
        future: ref.once().then((event) => event.snapshot.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            return onLoading ?? const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            // log('---> Value.once() -> Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text('Error; ${snapshot.error}');
          }

          return builder(snapshot.data as T, ref);
        },
      );
    }
  }
}

/// ValueListView
///
///
class ValueListView extends StatelessWidget {
  const ValueListView({
    super.key,
    required this.query,
    required this.builder,
    this.pageSize = 20,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.reverseQuery = false,
  });
  final Query query;
  final Widget Function(
    FirebaseQueryBuilderSnapshot snapshot,
    void Function(int index) fetchMore,
  ) builder;

  final int pageSize;
  final Widget Function()? loadingBuilder;
  final Widget Function(String)? errorBuilder;
  final Widget Function()? emptyBuilder;
  final bool reverseQuery;
  @override
  Widget build(BuildContext context) {
    return FirebaseDatabaseQueryBuilder(
      query: query,
      pageSize: pageSize,
      reverseQuery: reverseQuery,
      builder: (context, snapshot, _) {
        if (snapshot.hasError) {
          return errorBuilder?.call(snapshot.error.toString()) ??
              Center(child: Text('Something went wrong! ${snapshot.error}'));
        }

        if (snapshot.isFetching && snapshot.hasData == false) {
          return loadingBuilder?.call() ??
              const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasData && snapshot.docs.isEmpty && !snapshot.hasMore) {
          return emptyBuilder?.call() ??
              const Center(child: Text('Value list is empty'));
        }

        return builder(snapshot, (index) {
          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            snapshot.fetchMore();
          }
        });
      },
    );
  }
}

/// DateTime extension
///
///
extension SuperLibraryDateTimeExtension on DateTime {
  /// Returns a string of "yyyy-MM-dd"
  String get short => shortDateTime;

  /// Returns date if the date is today, otherwise returns time
  ///
  String get shortDateTime {
    return isToday ? jm : md;
  }

  /// Returns a string of "yyyy-MM-dd"
  String get yMd {
    return DateFormat.yMd().format(this);
  }

  /// Converts a string to a DateTime object and returns it in YYYY-MM-DD HH:mm:ss format.
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get yMdjm {
    return DateFormat.yM().add_jm().format(this);
  }

  /// Converts a string to a DateTime object and returns it in MM-DD format.
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get md {
    return DateFormat.Md().format(this);
  }

  /// Returns a string of "yyyy-MM-dd HH:mm:ss"
  String get jm {
    return DateFormat.jm().format(this);
  }

  /// Returns in the format of 'jms' (e.g. 5:08:37 PM)
  ///
  /// See also: https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html
  String get jms {
    return DateFormat.jms().format(this);
  }

  /// Returns a string of "yy-MM-dd"
  ///
  /// from: https://github.com/jayeshpansheriya/awesome_extensions/blob/main/lib/date_extensions/date_extension.dart
  bool get isToday {
    final nowDate = DateTime.now();
    return year == nowDate.year && month == nowDate.month && day == nowDate.day;
  }

  /// Returns true if the date is tomorrow
  bool get isTomorrow {
    final nowDate = DateTime.now();
    return year == nowDate.year &&
        month == nowDate.month &&
        day == nowDate.day + 1;
  }

  /// Returns true if the date is past.
  ///
  /// It returns true even if it is today but the time is past.
  ///
  /// It is a simple alias of `isBefore(DateTime.now())`.
  bool get isPast {
    final nowDate = DateTime.now();
    return isBefore(nowDate);
  }

  /// Returns true if the date is future.
  ///
  /// It returns true even if it is today but the time is future.
  ///
  /// It is a simple alias of `isAfter(DateTime.now())`.
  ///
  /// See also: https://api.flutter.dev/flutter/dart-core/DateTime/isBefore.html
  /// See also: https://api.flutter.dev/flutter/dart-core/DateTime/compareTo.html
  bool get isFuture {
    final nowDate = DateTime.now();
    return isAfter(nowDate);
  }

  /// The day after this [DateTime]
  DateTime get nextDay => add(const Duration(days: 1));

  /// The day previous this [DateTime]
  DateTime get previousDay => subtract(const Duration(days: 1));
}

/// Put this at the bottom !!
Future superLibrary() async {
  // Add your function code here!
}

// End custom action code
