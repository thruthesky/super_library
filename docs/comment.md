# Comment API

The `Comment API` offers a powerful and simple way to add comment feature to your app. It's versatile, perfect for things like blog comments, product reviews, or photo feedback.

It offers a complete set of UI/UX widgets and logics for managing comments including but not limited to CRUD, file uploading, likes, and much more.


## Overview

- It is best to use the SliverListView as it can get the comments little by little as user scrolls the screen up and down.
  - We can custom code it but it's not easy to provides a custom ui customization.
    - Until we find a way, we simply get all comments of the comments of the data and display it in list view.
  - And if you are building app with Flutter without FlutterFlow, we recommend you to use the SliverListView. And we encourage you to use Flutter (without FlutterFlow) if yo are good at source coding.


## Terms

- `Root`: An object that the comments belong to. It can be a user, photo, product item, blog/post, or whatever.
- `First level comments`: are comments created directly under a Root.






## Database Structure of Comment


# Widgets

## CommentInputBox

This is a simple comment create widget.

```dart
CommentInputBox(
  parent: comment,
),
```

```dart
SliverToBoxAdapter(
  child: CommentFakeInputBox(
    onTap: () => CommentService.instance.showCommentEditDialog(
      context: context,
      documentReference: ref,
      focusOnContent: true,
    ),
  ),
),
```

## Displaying comments

The `easy_comment` provides two list view widgets for displaying comments.

You can copy the code from `easy_comment` and build your own comment list view widget for different UI/UX,

### CommentListView

The first one is `CommentListView`. This is similar two `ListView`.

You can use `CommentListView` like below to display the comments.

```dart
CommentListView(
  documentReference: ref,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemBuilder: (comment, index) =>
      CommentListDetail(comment: comment),
),
```

For the `itemBuilder`, you may use one of `CommentDetail`, `CommentListDetail`, `CommentListArrowDetail`, or `CommentListVerticalLineDetail`. Or you can copy the code and build your own.

Example: Below is an example of using the available widgets.

```dart
CommentListView(
  documentReference: ref,
  itemBuilder: (comment, index) {
    return CommentListDetail(comment: comment); // default
    return CommentListArrowDetail(comment: comment); // arrow style comment
    return CommentListVerticalLineDetail(comment: comment); // vertical line comment
  },
),
```

### CommentListTreeView

`CommentListTreeView` provides a nice tree style vertical lines on the nested comment list. It is designed to work in sliver scroll view. So, you should use `CustomScrollView` on the screen.

```dart
SliverToBoxAdapter(
  child: CommentFakeInputBox(
    onTap: () => CommentService.instance.showCommentEditDialog(
      context: context,
      documentReference: task.ref,
      focusOnContent: true,
    ),
  ),
),
CommentListTreeView(documentReference: task.ref),
```

# onCreate CallBack

The `onCreate` is a callback after the comment is created.
You can use this callback to do something comment post is created.

Usage: (e.g. send push notification to ancestor uid)

In the example below, we can send push notification to ancestor uid after the comment is created. It contains the newly created `comment` information.

First we get the ancestor uids after the comment is created, then we send a push notification to the ancestor uids.

```dart
    CommentService.instance.init(
      onCreate: (Comment comment) async {
        /// get ancestor uid
        List<String> ancestorUids =
            await CommentService.instance.getAncestorsUid(comment.id);
        /// get post information
        Post post = await Post.get(comment.documentReference.id);
        if (myUid != null && post.uid != myUid) {
          ancestorUids.add(post.uid);
        }

        if (ancestorUids.isEmpty) return;

        /// set push notification to remaining uids
        /// can get comment or post to send more informative push notification
        MessagingService.instance.sendMessageToUids(
          uids: ancestorUids,
          title: 'title ${DateTime.now()}',
          body: 'ancestorComment test ${comment.content}',
          data: {
            "action": 'comment',
            'commentId': comment.id,
            'postId': comment.documentReference.id,
          },
        );
      },
    );
```

# Development Tips

## Testing

```dart
import 'package:easy_comment/easy_comment.dart';
import 'package:easy_post_v2/easy_post_v2.dart';
import 'package:easyuser/easyuser.dart';
import 'package:flutter/material.dart';

class CommentTestScreen extends StatefulWidget {
  static const String routeName = '/CommentTest';
  const CommentTestScreen({super.key});

  @override
  State<CommentTestScreen> createState() => _CommentTestScreenState();
}

class _CommentTestScreenState extends State<CommentTestScreen> {
  @override
  Widget build(BuildContext context) {
    // final ref = my.ref;
    // final ref = Post.col.doc('1zsZ2YMplgZN6D6bdZIn');
    // final ref = Post.col.doc('0-console');
    // final ref = Post.col.doc('0-console-2');
    // final ref = Post.col.doc('0-con-3');
    // final ref = Post.col.doc('0-a');
    // final ref = Post.col.doc('0-b');
    // final ref = Post.col.doc('0-c');
    final ref = Post.col.doc('0-4');
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommentTest'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 0),
        child: MyDocReady(
          builder: () => ListView(
            padding: const EdgeInsets.all(0),
            children: [
              Text('Reference: ${ref.path}'),
              const SizedBox(height: 24),
              CommentFakeInputBox(
                onTap: () => CommentService.instance.showCommentEditDialog(
                  context: context,
                  documentReference: ref,
                  focusOnContent: true,
                ),
              ),
              CommentInputBox(
                documentReference: ref,
              ),
              CommentListView(
                documentReference: ref,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (comment, index) =>
                    CommentListArrowDetail(comment: comment),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: CommentFakeInputBox(
          onTap: () => CommentService.instance.showCommentEditDialog(
            context: context,
            documentReference: ref,
            focusOnContent: true,
          ),
        ),
      ),
    );
  }
}
```
