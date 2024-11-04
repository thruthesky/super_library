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

class UserListTile extends StatefulWidget {
  const UserListTile({
    super.key,
    this.width,
    this.height,
    required this.data,
    required this.onTap,
  });

  final double? width;
  final double? height;
  final dynamic data;
  final Future Function(dynamic data) onTap;

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.fromJson(widget.data, widget.data['uid']);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      leading: UserAvatar(uid: user.uid),
      title: UserDisplayName(uid: user.uid, nameIfEmpty: 'Unknown...'),
      subtitle: Text(user.createdAt.toDateTime.short),
      onTap: () => widget.onTap?.call(widget.data),
    );
  }
}
