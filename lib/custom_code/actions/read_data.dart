// Automatic FlutterFlow imports
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

Future<dynamic> readData(
  BuildContext context,
  String key,
) async {
  // Add your function code here!

  try {
    final data = await Data.read(key);
    dog("readData() returns: $data");
    return data.data;
  } catch (e) {
    dog('Error on readData: $e');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error on readData: $e'),
        ),
      );
    }
    rethrow;
  }
}
