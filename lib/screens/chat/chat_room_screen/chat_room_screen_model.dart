import '/flutter_flow/flutter_flow_util.dart';
import 'chat_room_screen_widget.dart' show ChatRoomScreenWidget;
import 'package:flutter/material.dart';

class ChatRoomScreenModel extends FlutterFlowModel<ChatRoomScreenWidget> {
  ///  Local state fields for this page.

  String? roomId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getLoginUserUid] action in ChatRoomScreen widget.
  String? loginUserIdResult;
  // State field(s) for MessageTextField widget.
  FocusNode? messageTextFieldFocusNode;
  TextEditingController? messageTextFieldTextController;
  String? Function(BuildContext, String?)?
      messageTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    messageTextFieldFocusNode?.dispose();
    messageTextFieldTextController?.dispose();
  }
}
