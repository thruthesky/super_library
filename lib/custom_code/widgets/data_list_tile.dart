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

/// Displays the data in a list view.
///
/// [DataListTile] is a default custom widget that can be used in DataListView widget.
class DataListTile extends StatefulWidget {
  const DataListTile({
    super.key,
    this.width,
    this.height,
    required this.data,
    this.onTapProfilePhoto,
    this.onTap,
  });

  final double? width;
  final double? height;
  final dynamic data;
  final Future Function(String uid, String displayName, String photoUrl)?
      onTapProfilePhoto;
  final Future Function(dynamic data)? onTap;

  @override
  State<DataListTile> createState() => _DataListTileState();
}

class _DataListTileState extends State<DataListTile> {
  @override
  Widget build(BuildContext context) {
    final data = Data.fromJson(widget.data, widget.data['key']);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onTap?.call(data.data),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () =>
                          widget.onTapProfilePhoto?.call(
                            data.uid,
                            Memory.get<String>('displayName-${data.uid}') ?? '',
                            Memory.get<String>('photoUrl-${data.uid}') ?? '',
                          ) ??
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Use [onTap] callback action to DataDetailScreen. '
                                'Or customize your UI/UX to open Data Screen. '
                                'Refer to the developer documentation for details.',
                              ),
                            ),
                          ),
                      child: UserAvatar(uid: data.uid)),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      UserDisplayName(
                        uid: data.uid,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                data.content,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
