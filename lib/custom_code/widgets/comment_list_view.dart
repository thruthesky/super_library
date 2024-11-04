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

import '/custom_code/actions/super_library.dart';
import 'package:firebase_database/firebase_database.dart';

class CommentListView extends StatefulWidget {
  const CommentListView({
    super.key,
    this.width,
    this.height,
    required this.dataKey,
    required this.builder,
    this.shrinkWrap,
  });

  final double? width;
  final double? height;
  final String dataKey;
  final Widget Function(dynamic data) builder;
  final bool? shrinkWrap;

  @override
  State<CommentListView> createState() => _CommentListViewState();
}

class _CommentListViewState extends State<CommentListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      query: CommentService.instance.commentsRef
          .orderByChild('order')
          .startAt(widget.dataKey)
          .endAt(endRange(widget.dataKey)),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          shrinkWrap: widget.shrinkWrap ?? false,
          physics: widget.shrinkWrap == true
              ? const NeverScrollableScrollPhysics()
              : null,
          separatorBuilder: (context, index) => const Divider(
            height: 0,
          ),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot commentSnapshot = snapshot.docs[index];
            final Comment comment = Comment.fromSnapshot(commentSnapshot);

            return widget.builder(comment.toJson());
/*
            return widget.builder(createCommentStruct(
              key: comment.key,
              rootKey: comment.rootKey,
              parentKey: comment.parentKey,
              uid: comment.uid,
              content: comment.content,
              createdAt: comment.createdAt,
              updatedAt: comment.updatedAt,
              depth: comment.depth,
              order: comment.order,
              deleted: comment.deleted,
              isMine: comment.isMine,
            ));
            */
          },
        );
      },
      emptyBuilder: () => const Center(
        child: Text('No comment found'),
      ),
      errorBuilder: (error) => Center(
        child: Text('Error: $error'),
      ),
      loadingBuilder: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
