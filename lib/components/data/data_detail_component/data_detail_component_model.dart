import '/components/data/field/data_detail_content_component/data_detail_content_component_widget.dart';
import '/components/data/field/data_detail_title_component/data_detail_title_component_widget.dart';
import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'data_detail_component_widget.dart' show DataDetailComponentWidget;
import 'package:flutter/material.dart';

class DataDetailComponentModel
    extends FlutterFlowModel<DataDetailComponentWidget> {
  ///  Local state fields for this component.

  bool likeData = false;

  dynamic data;

  ///  State fields for stateful widgets in this component.

  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;
  // Model for ShortDateTimeComponent component.
  late ShortDateTimeComponentModel shortDateTimeComponentModel;
  // Model for DataDetailTitleComponent component.
  late DataDetailTitleComponentModel dataDetailTitleComponentModel;
  // Model for DataDetailContentComponent component.
  late DataDetailContentComponentModel dataDetailContentComponentModel;
  // Stores action output result for [Custom Action - readDataField] action in LikeButton widget.
  dynamic likeCountOutput;
  // Stores action output result for [Custom Action - reportExists] action in ReportButton widget.
  bool? isReportExist;

  @override
  void initState(BuildContext context) {
    userAvatarComponentModel =
        createModel(context, () => UserAvatarComponentModel());
    userDisplayNameComponentModel =
        createModel(context, () => UserDisplayNameComponentModel());
    shortDateTimeComponentModel =
        createModel(context, () => ShortDateTimeComponentModel());
    dataDetailTitleComponentModel =
        createModel(context, () => DataDetailTitleComponentModel());
    dataDetailContentComponentModel =
        createModel(context, () => DataDetailContentComponentModel());
  }

  @override
  void dispose() {
    userAvatarComponentModel.dispose();
    userDisplayNameComponentModel.dispose();
    shortDateTimeComponentModel.dispose();
    dataDetailTitleComponentModel.dispose();
    dataDetailContentComponentModel.dispose();
  }
}
