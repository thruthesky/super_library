import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'user_list_tile_component_model.dart';
export 'user_list_tile_component_model.dart';

class UserListTileComponentWidget extends StatefulWidget {
  const UserListTileComponentWidget({
    super.key,
    this.data,
    required this.onTap,
  });

  final dynamic data;
  final Future Function(dynamic data)? onTap;

  @override
  State<UserListTileComponentWidget> createState() =>
      _UserListTileComponentWidgetState();
}

class _UserListTileComponentWidgetState
    extends State<UserListTileComponentWidget> {
  late UserListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListTileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return custom_widgets.UserListTile(
      width: double.infinity,
      height: 100.0,
      data: widget.data!,
      onTap: (data) async {
        await widget.onTap?.call(
          widget.data!,
        );
      },
    );
  }
}
