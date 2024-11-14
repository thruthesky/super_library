import '/components/comment/comment_list_view_component/comment_list_view_component_widget.dart';
import '/components/data/data_detail_component/data_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_details_screen_copy_widget.dart' show PostDetailsScreenCopyWidget;
import 'package:flutter/material.dart';

class PostDetailsScreenCopyModel
    extends FlutterFlowModel<PostDetailsScreenCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataDetailComponent component.
  late DataDetailComponentModel dataDetailComponentModel;
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
