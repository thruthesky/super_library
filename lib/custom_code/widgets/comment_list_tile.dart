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

class CommentListTile extends StatefulWidget {
  const CommentListTile({
    super.key,
    this.width,
    this.height,
    required this.commentData,
  });

  final double? width;
  final double? height;
  final dynamic commentData;

  @override
  State<CommentListTile> createState() => _CommentListTileState();
}

class _CommentListTileState extends State<CommentListTile> {
  @override
  Widget build(BuildContext context) {
    final comment =
        Comment.fromJson(widget.commentData, widget.commentData['key']);
    return Container(
      margin: EdgeInsets.only(left: comment.depth * 32.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(uid: comment.uid),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserDisplayName(uid: comment.uid),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(comment.depth.toString()),
            Text(comment.order.toString()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                comment.content,
                style: FlutterFlowTheme.of(context).bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
