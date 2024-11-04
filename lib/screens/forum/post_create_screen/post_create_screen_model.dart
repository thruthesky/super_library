import '/components/data/data_create_component/data_create_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'post_create_screen_widget.dart' show PostCreateScreenWidget;
import 'package:flutter/material.dart';

class PostCreateScreenModel extends FlutterFlowModel<PostCreateScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for DataCreateComponent component.
  late DataCreateComponentModel dataCreateComponentModel;

  @override
  void initState(BuildContext context) {
    dataCreateComponentModel =
        createModel(context, () => DataCreateComponentModel());
  }

  @override
  void dispose() {
    dataCreateComponentModel.dispose();
  }
}
