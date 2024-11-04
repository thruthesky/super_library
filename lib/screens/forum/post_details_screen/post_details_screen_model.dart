import '/components/comment/comment_list_view_component/comment_list_view_component_widget.dart';
import '/components/data/data_detail_component/data_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_details_screen_widget.dart' show PostDetailsScreenWidget;
import 'package:flutter/material.dart';

class PostDetailsScreenModel extends FlutterFlowModel<PostDetailsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataDetailComponent component.
  late DataDetailComponentModel dataDetailComponentModel;
  // Stores action output result for [Custom Action - reportExists] action in DataDetailComponent widget.
  bool? isReportExist;
  // Model for CommentListViewComponent component.
  late CommentListViewComponentModel commentListViewComponentModel;

  @override
  void initState(BuildContext context) {
    dataDetailComponentModel =
        createModel(context, () => DataDetailComponentModel());
    commentListViewComponentModel =
        createModel(context, () => CommentListViewComponentModel());
  }

  @override
  void dispose() {
    dataDetailComponentModel.dispose();
    commentListViewComponentModel.dispose();
  }
}
