// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

/// Displays the comment reply form.
class ReplyForm extends StatefulWidget {
  const ReplyForm({
    super.key,
    this.width,
    this.height,
    required this.data,
  });

  final double? width;
  final double? height;
  final dynamic data;

  @override
  State<ReplyForm> createState() => _ReplyFormState();
}

class _ReplyFormState extends State<ReplyForm> {
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('You are replying to:'),
            const SizedBox(height: 16),
            Row(
              children: [
                UserAvatar(uid: widget.data['uid']),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserDisplayName(uid: widget.data['uid']),
                      Text(
                        ((widget.data['title'] as String?) ??
                                (widget.data['content'] as String?) ??
                                '')
                            .cut(64),
                        style: FlutterFlowTheme.of(context).titleSmall,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Type reply',
                hintText: 'Type your reply here...',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ElevatedButton(
                      onPressed: () async {
                        print(widget.data);
                        await createComment(
                          context,
                          widget.data,
                          contentController.text,
                          [],
                          {},
                          (ref) async => null,
                          (e) async =>
                              ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to create comment: $e',
                              ),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Reply',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
