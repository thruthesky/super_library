import '/components/data/data_detail_component/data_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_details_screen_widget.dart' show PostDetailsScreenWidget;
import 'package:flutter/material.dart';

class PostDetailsScreenModel extends FlutterFlowModel<PostDetailsScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataDetailComponent component.
  late DataDetailComponentModel dataDetailComponentModel;

  @override
  void initState(BuildContext context) {
    dataDetailComponentModel =
        createModel(context, () => DataDetailComponentModel());
  }

  @override
  void dispose() {
    dataDetailComponentModel.dispose();
  }
}
