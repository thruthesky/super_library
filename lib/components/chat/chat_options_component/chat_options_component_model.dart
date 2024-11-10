import '/components/chat/chat_option_tile_component/chat_option_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'chat_options_component_widget.dart' show ChatOptionsComponentWidget;
import 'package:flutter/material.dart';

class ChatOptionsComponentModel
    extends FlutterFlowModel<ChatOptionsComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ChatOptionTileComponent component.
  late ChatOptionTileComponentModel chatOptionTileComponentModel1;
  // Stores action output result for [Custom Action - readChatRoom] action in ChatOptionTileComponent widget.
  dynamic chatRoomResult;
  // Model for ChatOptionTileComponent component.
  late ChatOptionTileComponentModel chatOptionTileComponentModel2;
  // Model for ChatOptionTileComponent component.
  late ChatOptionTileComponentModel chatOptionTileComponentModel3;

  @override
  void initState(BuildContext context) {
    chatOptionTileComponentModel1 =
        createModel(context, () => ChatOptionTileComponentModel());
    chatOptionTileComponentModel2 =
        createModel(context, () => ChatOptionTileComponentModel());
    chatOptionTileComponentModel3 =
        createModel(context, () => ChatOptionTileComponentModel());
  }

  @override
  void dispose() {
    chatOptionTileComponentModel1.dispose();
    chatOptionTileComponentModel2.dispose();
    chatOptionTileComponentModel3.dispose();
  }
}
