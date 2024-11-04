import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'user_list_tile_component_widget.dart' show UserListTileComponentWidget;
import 'package:flutter/material.dart';

class UserListTileComponentModel
    extends FlutterFlowModel<UserListTileComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel =
        createModel(context, () => UserAvatarComponentModel());
    userDisplayNameComponentModel =
        createModel(context, () => UserDisplayNameComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel.dispose();
    userDisplayNameComponentModel.dispose();
  }
}