import '/components/user/user_list_tile_component/user_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'feed_list_tile_component_widget.dart' show FeedListTileComponentWidget;
import 'package:flutter/material.dart';

class FeedListTileComponentModel
    extends FlutterFlowModel<FeedListTileComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for UserListTileComponent component.
  late UserListTileComponentModel userListTileComponentModel;

  @override
  void initState(BuildContext context) {
    userListTileComponentModel =
        createModel(context, () => UserListTileComponentModel());
  }

  @override
  void dispose() {
    userListTileComponentModel.dispose();
  }
}
