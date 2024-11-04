import '/flutter_flow/flutter_flow_util.dart';
import 'report_bottom_sheet_component_widget.dart'
    show ReportBottomSheetComponentWidget;
import 'package:flutter/material.dart';

class ReportBottomSheetComponentModel
    extends FlutterFlowModel<ReportBottomSheetComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for reasonTextField widget.
  FocusNode? reasonTextFieldFocusNode;
  TextEditingController? reasonTextFieldTextController;
  String? Function(BuildContext, String?)?
      reasonTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reasonTextFieldFocusNode?.dispose();
    reasonTextFieldTextController?.dispose();
  }
}
