import '/flutter_flow/flutter_flow_util.dart';
import 'chat_room_invite_component_widget.dart'
    show ChatRoomInviteComponentWidget;
import 'package:flutter/material.dart';

class ChatRoomInviteComponentModel
    extends FlutterFlowModel<ChatRoomInviteComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
