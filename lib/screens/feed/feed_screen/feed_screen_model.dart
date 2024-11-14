import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'feed_screen_widget.dart' show FeedScreenWidget;
import 'package:flutter/material.dart';

class FeedScreenModel extends FlutterFlowModel<FeedScreenWidget> {
  ///  Local state fields for this page.

  dynamic dataA;

  dynamic dataB;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getWhoIFollow] action in FeedScreen widget.
  List<String>? getWhoIFollowOutput;
  // Stores action output result for [Custom Action - getWhoFollowMe] action in FeedScreen widget.
  List<dynamic>? getWhoFollowMeOutput;
  // Models for UserAvatarComponent dynamic component.
  late FlutterFlowDynamicModels<UserAvatarComponentModel>
      userAvatarComponentModels1;
  // Models for UserDisplayNameComponent dynamic component.
  late FlutterFlowDynamicModels<UserDisplayNameComponentModel>
      userDisplayNameComponentModels1;
  // Models for UserAvatarComponent dynamic component.
  late FlutterFlowDynamicModels<UserAvatarComponentModel>
      userAvatarComponentModels2;
  // Models for UserDisplayNameComponent dynamic component.
  late FlutterFlowDynamicModels<UserDisplayNameComponentModel>
      userDisplayNameComponentModels2;
  // Stores action output result for [Custom Action - readData] action in CreateFeedA widget.
  dynamic readAOutput;
  // Stores action output result for [Custom Action - readData] action in CreateFeedB widget.
  dynamic readBOutput;
  // Stores action output result for [Custom Action - readData] action in UpdateFeedA widget.
  dynamic updatedFeedAOutput;
  // Stores action output result for [Custom Action - readData] action in UpdateFeedB widget.
  dynamic updatedFeedBOutput;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModels1 =
        FlutterFlowDynamicModels(() => UserAvatarComponentModel());
    userDisplayNameComponentModels1 =
        FlutterFlowDynamicModels(() => UserDisplayNameComponentModel());
    userAvatarComponentModels2 =
        FlutterFlowDynamicModels(() => UserAvatarComponentModel());
    userDisplayNameComponentModels2 =
        FlutterFlowDynamicModels(() => UserDisplayNameComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModels1.dispose();
    userDisplayNameComponentModels1.dispose();
    userAvatarComponentModels2.dispose();
    userDisplayNameComponentModels2.dispose();
  }
}
