import '/flutter_flow/flutter_flow_util.dart';
import 'chat_room_info_component_widget.dart' show ChatRoomInfoComponentWidget;
import 'package:flutter/material.dart';

class ChatRoomInfoComponentModel
    extends FlutterFlowModel<ChatRoomInfoComponentWidget> {
  ///  Local state fields for this component.

  List<String> userUids = [];
  void addToUserUids(String item) => userUids.add(item);
  void removeFromUserUids(String item) => userUids.remove(item);
  void removeAtIndexFromUserUids(int index) => userUids.removeAt(index);
  void insertAtIndexInUserUids(int index, String item) =>
      userUids.insert(index, item);
  void updateUserUidsAtIndex(int index, Function(String) updateFn) =>
      userUids[index] = updateFn(userUids[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for open widget.
  bool? openValue;
  // State field(s) for allMembersCanInvite widget.
  bool? allMembersCanInviteValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
