import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  Local state fields for this page.

  String? loginUserUidState;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - loginUserUid] action in HomeScreen widget.
  String? loginUserUidActionOutput;
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
