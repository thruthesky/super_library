import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_screen_widget.dart' show HomeScreenWidget;
import 'package:flutter/material.dart';

class HomeScreenModel extends FlutterFlowModel<HomeScreenWidget> {
  ///  Local state fields for this page.

  String? loginUserUidState;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getLoginUserUid] action in HomeScreen widget.
  String? loginUserUidActionOutput;
  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel1;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;
  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel2;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel1 =
        createModel(context, () => UserAvatarComponentModel());
    userDisplayNameComponentModel =
        createModel(context, () => UserDisplayNameComponentModel());
    userAvatarComponentModel2 =
        createModel(context, () => UserAvatarComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel1.dispose();
    userDisplayNameComponentModel.dispose();
    userAvatarComponentModel2.dispose();
  }
}
