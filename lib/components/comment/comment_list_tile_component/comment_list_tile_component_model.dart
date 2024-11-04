import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'comment_list_tile_component_widget.dart'
    show CommentListTileComponentWidget;
import 'package:flutter/material.dart';

class CommentListTileComponentModel
    extends FlutterFlowModel<CommentListTileComponentWidget> {
  ///  Local state fields for this component.

  bool likeData = false;

  ///  State fields for stateful widgets in this component.

  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for ShortDateTimeComponent component.
  late ShortDateTimeComponentModel shortDateTimeComponentModel;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;
  // Stores action output result for [Custom Action - reportExists] action in ReportButton widget.
  bool? isReportExist;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel =
        createModel(context, () => UserAvatarComponentModel());
    shortDateTimeComponentModel =
        createModel(context, () => ShortDateTimeComponentModel());
    userDisplayNameComponentModel =
        createModel(context, () => UserDisplayNameComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel.dispose();
    shortDateTimeComponentModel.dispose();
    userDisplayNameComponentModel.dispose();
  }
}
