import '/components/data/data_list_view_component/data_list_view_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_list_screen_widget.dart' show PostListScreenWidget;
import 'package:flutter/material.dart';

class PostListScreenModel extends FlutterFlowModel<PostListScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataListViewComponent component.
  late DataListViewComponentModel dataListViewComponentModel;

  @override
  void initState(BuildContext context) {
    dataListViewComponentModel =
        createModel(context, () => DataListViewComponentModel());
  }

  @override
  void dispose() {
    dataListViewComponentModel.dispose();
  }
}
