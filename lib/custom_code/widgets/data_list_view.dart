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

class DataListView extends StatefulWidget {
  const DataListView({
    super.key,
    this.width,
    this.height,
    required this.category,
    required this.builder,
  });

  final double? width;
  final double? height;
  final String category;

  final Widget Function(dynamic data) builder;

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  @override
  Widget build(BuildContext context) {
    return ValueListView(
      reverseQuery: true,
      query: Ref.data
          .orderByChild('category')
          .startAt(widget.category)
          .endAt(endRange(widget.category)),
      builder: (snapshot, fetchMore) {
        return ListView.separated(
          itemCount: snapshot.docs.length,
          separatorBuilder: (context, index) => SizedBox.shrink(),
          itemBuilder: (context, index) {
            fetchMore(index);
            final DataSnapshot doc = snapshot.docs[index];
            final Data data = Data.fromSnapshot(doc);

            return widget.builder(data.toJson());

            // return widget.builder(data.data);
          },
        );
      },
      emptyBuilder: () => const Center(
        child: Text('No data found!'),
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
