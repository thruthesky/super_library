import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'data_list_tile_component_widget.dart' show DataListTileComponentWidget;
import 'package:flutter/material.dart';

class DataListTileComponentModel
    extends FlutterFlowModel<DataListTileComponentWidget> {
  ///  Local state fields for this component.

  List<String> urls = [];
  void addToUrls(String item) => urls.add(item);
  void removeFromUrls(String item) => urls.remove(item);
  void removeAtIndexFromUrls(int index) => urls.removeAt(index);
  void insertAtIndexInUrls(int index, String item) => urls.insert(index, item);
  void updateUrlsAtIndex(int index, Function(String) updateFn) =>
      urls[index] = updateFn(urls[index]);

  ///  State fields for stateful widgets in this component.

  // Model for UserAvatarComponent component.
  late UserAvatarComponentModel userAvatarComponentModel;
  // Model for UserDisplayNameComponent component.
  late UserDisplayNameComponentModel userDisplayNameComponentModel;

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
