// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';
import '/custom_code/actions/super_library.dart';

/// Feed Data Class
///
/// It does feed data modeling and has the base feed CRUD operations.
class Feed {
  static const field = (
    key: 'key',
    title: 'title',
    content: 'content',
    urls: 'urls',
    displayName: 'displayName',
    photoUrl: 'photoUrl',
    uid: 'uid',
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
  );

  final String key;
  final String title;
  final String content;
  final List<String> urls;
  final String displayName;
  final String photoUrl;
  final String uid;
  final int createdAt;
  final int updatedAt;

  Feed({
    required this.key,
    required this.title,
    required this.content,
    required this.urls,
    required this.displayName,
    required this.photoUrl,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Feed.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.exists == false) {
      throw 'feed-modeling/feed-not-exist Feed does not exist';
    }
    final docSnapshot = snapshot.value as Map;
    return Feed.fromJson(docSnapshot, snapshot.key!);
  }

  factory Feed.fromJson(Map<dynamic, dynamic> json, String key) {
    return Feed(
      key: key,
      title: json[field.title] ?? '',
      content: json[field.content] ?? '',
      urls: List<String>.from(json[field.urls] ?? []),
      displayName: json[field.displayName] ?? '',
      photoUrl: json[field.photoUrl] ?? '',
      uid: json[field.uid],
      createdAt: json[field.createdAt] ?? DateTime.now().millisecondsSinceEpoch,
      updatedAt: json[field.updatedAt] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      field.key: key,
      field.title: title,
      field.content: content,
      field.urls: urls,
      field.displayName: displayName,
      field.photoUrl: photoUrl,
      field.uid: uid,
      field.createdAt: createdAt,
      field.updatedAt: updatedAt,
    };
  }

  /// When a user creates a `data`, it will store the summary of the data
  /// including title, content(255 chars only), urls, displayName,
  /// photoUrl, etc to the feed of the user.
  static create(Map<dynamic, dynamic> data) async {
    final followersUids = await FeedService.instance.myFollowerUids();
    if (followersUids.isEmpty) return;

    final newData = {
      field.title: data[field.title],
      field.content: data[field.content],
      field.urls: data[field.urls],
      field.displayName: my[FFUser.displayName],
      field.photoUrl: my[FFUser.photoURL],
      field.uid: myUid,
      field.createdAt: data[field.createdAt],
      field.updatedAt: data[field.updatedAt],
    };
    final Map<String, Object?> updates = {};
    final dataKey = data[field.key];
    for (String uid in followersUids) {
      updates['/follow/feed/$uid/$dataKey'] = newData;
    }
    await database.ref().update(updates);
  }

  static update(Map<dynamic, dynamic> data) async {
    final followersUids = await FeedService.instance.myFollowerUids();
    if (followersUids.isEmpty) return;
    final newData = {
      field.title: data[field.title],
      field.content: data[field.content],
      field.urls: data[field.urls],
      field.displayName: my[FFUser.displayName],
      field.photoUrl: my[FFUser.photoURL],
      field.uid: myUid,
      field.createdAt: data[field.createdAt],
      field.updatedAt: data[field.updatedAt],
    };
    final Map<String, Object?> updates = {};
    final dataKey = data[field.key];
    for (String uid in followersUids) {
      updates['/follow/feed/$uid/$dataKey'] = newData;
    }
    await database.ref().update(updates);
  }

  static delete(String dataKey) async {
    final followersUids = await FeedService.instance.myFollowerUids();
    if (followersUids.isEmpty) return;
    final Map<String, Object?> updates = {};
    for (String uid in followersUids) {
      updates['/follow/feed/$uid/$dataKey'] = null;
    }
    await database.ref().update(updates);
  }
}

/// FeedListView displays the feed list of the login user
class FeedListView extends StatelessWidget {
  const FeedListView({
    super.key,
    required this.builder,
    this.shrinkWrap,
  });
  final Widget Function(dynamic data) builder;
  final bool? shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return MyDoc(builder: (data) {
      if (data == null) {
        return const Center(
          child: Text('Please sign in to see feeds'),
        );
      }
      return ValueListView(
        query: FeedService.instance.myFeedRef.orderByChild('updatedAt'),
        reverseQuery: true,
        builder: (snapshot, fetchMore) {
          return ListView.separated(
            itemCount: snapshot.docs.length,
            shrinkWrap: shrinkWrap ?? false,
            physics: shrinkWrap == true
                ? const NeverScrollableScrollPhysics()
                : null,
            separatorBuilder: (context, index) => const Divider(
              height: 0,
            ),
            itemBuilder: (context, index) {
              fetchMore(index);
              final DataSnapshot feedSnapshot = snapshot.docs[index];
              final Feed feed = Feed.fromSnapshot(feedSnapshot);

              return builder(feed.toJson());
            },
          );
        },
        emptyBuilder: () => const Center(
          child: Text('No feeds found'),
        ),
        errorBuilder: (error) => Center(
          child: Text('Error: $error'),
        ),
        loadingBuilder: () => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    });
  }
}

Future feedApi() async {
  // Add your function code here!
}

class FeedService {
  static FeedService? _instance;
  static FeedService get instance => _instance ??= FeedService._();

  FeedService._() {
    /// Initialize your service
    /// This will be called only one time in the whole app lifecycle(session).

    ///
  }

  DatabaseReference get followRef => database.ref('follow');

  DatabaseReference get whoIfollowRef => followRef.child('who-i-follow');

  DatabaseReference get whoFollowMeRef => followRef.child('who-follow-me');

  DatabaseReference get myFollowerRef => whoFollowMeRef.child(myUid);

  DatabaseReference get myFollowingRef => whoIfollowRef.child(myUid);

  DatabaseReference myFollowToOtherRef(String otherUid) =>
      whoFollowMeRef.child(otherUid).child(myUid);

  DatabaseReference myFollowingToOtherRef(String otherUid) =>
      whoIfollowRef.child(myUid).child(otherUid);

  DatabaseReference get feedRef => followRef.child('feed');
  DatabaseReference get myFeedRef => feedRef.child(myUid);

  Future<List<String>> myFollowerUids() async {
    final followers = await FeedService.instance.getWhoFollowMe();
    final uids = followers.map((e) => e['uid']).toList();
    return List<String>.from(uids);
  }

  Future<List<Map<String, dynamic>>> getWhoFollowMe() async {
    final snapshot = await myFollowerRef.get();

    if (snapshot.exists == false) {
      return [];
    }

    final data = snapshot.value as Map<dynamic, dynamic>;

    List<Map<String, dynamic>> result = [];
    for (var uid in data.keys) {
      result.add({
        'uid': uid,
        'subscription': data[uid],
      });
    }
    return result;
  }

  Future<List<String>> getWhoIFollow() async {
    if (currentUserUid == null) {
      throw SuperLibraryException(
          'getWhoIFollow/sign-in-required', 'User is not signed in');
    }
    final snapshot = await myFollowingRef.get();
    if (snapshot.exists == false) {
      return [];
    }
    final data = snapshot.value as Map<dynamic, dynamic>;
    return List<String>.from(data.keys.toList());
  }

  Future follow(String otherUid) async {
    if (currentUserUid == null) {
      throw SuperLibraryException(
          'follow/sign-in-required', 'User is not signed in');
    }

    final snapshot = await myFollowToOtherRef(otherUid).get();
    if (snapshot.exists == true) {
      throw SuperLibraryException(
          'follow/already-following', 'Already following this User');
    }

    await database.ref().update({
      myFollowToOtherRef(otherUid).path: true,
      myFollowingToOtherRef(otherUid).path: true,
    });
  }

  Future unfollow(String otherUid) async {
    if (currentUserUid == null) {
      throw SuperLibraryException(
          'unfollow/sign-in-required', 'User is not signed in');
    }
    final snapshot = await myFollowToOtherRef(otherUid).get();
    if (snapshot.exists == false) {
      throw SuperLibraryException(
          'follow/not-following', 'User not in your following list');
    }

    await database.ref().update({
      myFollowToOtherRef(otherUid).path: null,
      myFollowingToOtherRef(otherUid).path: null,
    });
  }
}
