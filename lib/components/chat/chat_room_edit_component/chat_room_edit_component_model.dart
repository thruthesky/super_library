import '/flutter_flow/flutter_flow_util.dart';
import 'chat_room_edit_component_widget.dart' show ChatRoomEditComponentWidget;
import 'package:flutter/material.dart';

class ChatRoomEditComponentModel
    extends FlutterFlowModel<ChatRoomEditComponentWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  String? _nameTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'tsv7b0ee' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  // State field(s) for open widget.
  bool? openValue;
  // State field(s) for invite widget.
  bool? inviteValue;

  @override
  void initState(BuildContext context) {
    nameTextController1Validator = _nameTextController1Validator;
  }

  @override
  void dispose() {
    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();
  }
}
