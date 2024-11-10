import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'chat_members_list_tile_model.dart';
export 'chat_members_list_tile_model.dart';

class ChatMembersListTileWidget extends StatefulWidget {
  const ChatMembersListTileWidget({
    super.key,
    required this.uid,
  });

  final String? uid;

  @override
  State<ChatMembersListTileWidget> createState() =>
      _ChatMembersListTileWidgetState();
}

class _ChatMembersListTileWidgetState extends State<ChatMembersListTileWidget> {
  late ChatMembersListTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMembersListTileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        wrapWithModel(
          model: _model.userAvatarComponentModel,
          updateCallback: () => safeSetState(() {}),
          child: UserAvatarComponentWidget(
            uid: widget.uid!,
            size: 48.0,
            radius: 24.0,
          ),
        ),
        wrapWithModel(
          model: _model.userDisplayNameComponentModel,
          updateCallback: () => safeSetState(() {}),
          child: UserDisplayNameComponentWidget(
            uid: widget.uid!,
          ),
        ),
      ].divide(const SizedBox(width: 16.0)),
    );
  }
}
