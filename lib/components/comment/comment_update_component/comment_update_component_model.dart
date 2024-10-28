import '/flutter_flow/flutter_flow_util.dart';
import 'comment_update_component_widget.dart' show CommentUpdateComponentWidget;
import 'package:flutter/material.dart';

class CommentUpdateComponentModel
    extends FlutterFlowModel<CommentUpdateComponentWidget> {
  ///  Local state fields for this component.

  List<String> urls = [];
  void addToUrls(String item) => urls.add(item);
  void removeFromUrls(String item) => urls.remove(item);
  void removeAtIndexFromUrls(int index) => urls.removeAt(index);
  void insertAtIndexInUrls(int index, String item) => urls.insert(index, item);
  void updateUrlsAtIndex(int index, Function(String) updateFn) =>
      urls[index] = updateFn(urls[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for content widget.
  FocusNode? contentFocusNode;
  TextEditingController? contentTextController;
  String? Function(BuildContext, String?)? contentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    contentFocusNode?.dispose();
    contentTextController?.dispose();
  }
}
