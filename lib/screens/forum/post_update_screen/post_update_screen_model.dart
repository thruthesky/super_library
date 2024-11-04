import '/components/data/data_update_component/data_update_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_update_screen_widget.dart' show PostUpdateScreenWidget;
import 'package:flutter/material.dart';

class PostUpdateScreenModel extends FlutterFlowModel<PostUpdateScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataUpdateComponent component.
  late DataUpdateComponentModel dataUpdateComponentModel;

  @override
  void initState(BuildContext context) {
    dataUpdateComponentModel =
        createModel(context, () => DataUpdateComponentModel());
  }

  @override
  void dispose() {
    dataUpdateComponentModel.dispose();
  }
}
