import '/flutter_flow/flutter_flow_util.dart';
import 'chat_room_create_component_widget.dart'
    show ChatRoomCreateComponentWidget;
import 'package:flutter/material.dart';

class ChatRoomCreateComponentModel
    extends FlutterFlowModel<ChatRoomCreateComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'd58634pk' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for open widget.
  bool? openValue;
  // State field(s) for invite widget.
  bool? inviteValue;
  // Stores action output result for [Custom Action - createChatRoom] action in Create widget.
  String? newChatRoomId;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
