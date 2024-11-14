import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'public_profile_screen_widget.dart' show PublicProfileScreenWidget;
import 'package:flutter/material.dart';

class PublicProfileScreenModel
    extends FlutterFlowModel<PublicProfileScreenWidget> {
  ///  Local state fields for this page.

  bool likeData = false;

  int? likeCount;

  bool isFollowing = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - readPathField] action in PublicProfileScreen widget.
  dynamic likeCountOutputInit;
  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;
  // Stores action output result for [Custom Action - readPathField] action in LikeButton widget.
  dynamic likeCountOutput;

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
