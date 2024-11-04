import '/flutter_flow/flutter_flow_util.dart';
import 'profile_update_screen_widget.dart' show ProfileUpdateScreenWidget;
import 'package:flutter/material.dart';

class ProfileUpdateScreenModel
    extends FlutterFlowModel<ProfileUpdateScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for displayName widget.
  FocusNode? displayNameFocusNode;
  TextEditingController? displayNameTextController;
  String? Function(BuildContext, String?)? displayNameTextControllerValidator;
  // State field(s) for photoUrl widget.
  FocusNode? photoUrlFocusNode;
  TextEditingController? photoUrlTextController;
  String? Function(BuildContext, String?)? photoUrlTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    displayNameFocusNode?.dispose();
    displayNameTextController?.dispose();

    photoUrlFocusNode?.dispose();
    photoUrlTextController?.dispose();
  }
}
