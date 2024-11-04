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
import '/custom_code/actions/super_library.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_database/firebase_database.dart';

class DataChangeListener extends StatefulWidget {
  const DataChangeListener({
    super.key,
    this.width,
    this.height,
    required this.path,
    required this.onChange,
  });

  final double? width;
  final double? height;
  final String path;
  final Future Function(dynamic data) onChange;

  @override
  State<DataChangeListener> createState() => _DataChangeListenerState();
}

class _DataChangeListenerState extends State<DataChangeListener> {
  late StreamSubscription stream;

  @override
  initState() {
    super.initState();

    stream = database.ref(widget.path).onValue.listen((event) async {
      dog(event.snapshot.value);

      print("DataChangeListener -> ${event.snapshot.value}");
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        if (mounted && event.snapshot.exists == false) {
          widget.onChange(null);
          return;
        }
        final DataSnapshot doc = event.snapshot;
        final Data data = Data.fromSnapshot(doc);
        if (mounted) widget.onChange(data.toJson());
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    stream.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
