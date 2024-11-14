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

import '/custom_code/actions/feed_api.dart' as feed;

class FeedListView extends StatefulWidget {
  const FeedListView({
    super.key,
    this.width,
    this.height,
    this.shrinkWrap = true,
    required this.builder,
  });

  final double? width;
  final double? height;
  final bool shrinkWrap;

  final Widget Function(dynamic data) builder;

  @override
  State<FeedListView> createState() => _FeedListViewState();
}

class _FeedListViewState extends State<FeedListView> {
  @override
  Widget build(BuildContext context) {
    return feed.FeedListView(
      shrinkWrap: widget.shrinkWrap,
      builder: widget.builder,
    );
  }
}
