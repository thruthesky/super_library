import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'chat_room_name_component_model.dart';
export 'chat_room_name_component_model.dart';

class ChatRoomNameComponentWidget extends StatefulWidget {
  const ChatRoomNameComponentWidget({
    super.key,
    required this.uidOrRoomId,
    this.fontSize,
    this.fontColor,
  });

  final String? uidOrRoomId;
  final double? fontSize;
  final Color? fontColor;

  @override
  State<ChatRoomNameComponentWidget> createState() =>
      _ChatRoomNameComponentWidgetState();
}

class _ChatRoomNameComponentWidgetState
    extends State<ChatRoomNameComponentWidget> {
  late ChatRoomNameComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRoomNameComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            custom_widgets.ChatRoomName(
              width: 1.0,
              height: 1.0,
              uidOrRoomId: widget.uidOrRoomId!,
            ),
            if (false)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  FFLocalizations.of(context).getText(
                    '5k6qkt9g' /* [ Chat Room Name ] */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: widget.fontColor,
                        fontSize: widget.fontSize,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
