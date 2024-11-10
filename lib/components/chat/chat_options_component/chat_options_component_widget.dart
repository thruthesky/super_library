import '/components/chat/chat_option_tile_component/chat_option_tile_component_widget.dart';
import '/components/chat/chat_room_edit_component/chat_room_edit_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'chat_options_component_model.dart';
export 'chat_options_component_model.dart';

class ChatOptionsComponentWidget extends StatefulWidget {
  const ChatOptionsComponentWidget({
    super.key,
    required this.uidOrRoomId,
    required this.onLeave,
  });

  final String? uidOrRoomId;
  final Future Function()? onLeave;

  @override
  State<ChatOptionsComponentWidget> createState() =>
      _ChatOptionsComponentWidgetState();
}

class _ChatOptionsComponentWidgetState
    extends State<ChatOptionsComponentWidget> {
  late ChatOptionsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatOptionsComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 4.0,
              color: Color(0x33000000),
              offset: Offset(
                0.0,
                2.0,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 0.0, 12.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'g58nc2zn' /* Options */,
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              Builder(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    _model.chatRoomResult = await actions.readChatRoom(
                      widget.uidOrRoomId!,
                      false,
                    );
                    Navigator.pop(context);
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: const AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: ChatRoomEditComponentWidget(
                            uidOrRoomId: widget.uidOrRoomId!,
                            room: _model.chatRoomResult!,
                          ),
                        );
                      },
                    );

                    safeSetState(() {});
                  },
                  child: wrapWithModel(
                    model: _model.chatOptionTileComponentModel1,
                    updateCallback: () => safeSetState(() {}),
                    child: ChatOptionTileComponentWidget(
                      icon: Icon(
                        Icons.edit_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 20.0,
                      ),
                      text: 'Edit Chat',
                    ),
                  ),
                ),
              ),
              wrapWithModel(
                model: _model.chatOptionTileComponentModel2,
                updateCallback: () => safeSetState(() {}),
                child: ChatOptionTileComponentWidget(
                  icon: Icon(
                    Icons.person_add,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 20.0,
                  ),
                  text: 'Invite Others',
                ),
              ),
              Divider(
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).alternate,
              ),
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  var confirmDialogResponse = await showDialog<bool>(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: const Text('Leaving Chat'),
                            content: const Text(
                                'Are you sure you want to leave this chat?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext, true),
                                child: const Text('Confirm'),
                              ),
                            ],
                          );
                        },
                      ) ??
                      false;
                  if (confirmDialogResponse) {
                    await actions.leaveChatRoom(
                      widget.uidOrRoomId!,
                    );
                    await widget.onLeave?.call();
                  }
                },
                child: wrapWithModel(
                  model: _model.chatOptionTileComponentModel3,
                  updateCallback: () => safeSetState(() {}),
                  child: ChatOptionTileComponentWidget(
                    icon: Icon(
                      Icons.exit_to_app_sharp,
                      color: FlutterFlowTheme.of(context).error,
                      size: 20.0,
                    ),
                    text: 'Leave Chat Room',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
