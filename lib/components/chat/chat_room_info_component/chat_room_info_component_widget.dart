import '/components/chat/chat_members_list_tile/chat_members_list_tile_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'chat_room_info_component_model.dart';
export 'chat_room_info_component_model.dart';

class ChatRoomInfoComponentWidget extends StatefulWidget {
  const ChatRoomInfoComponentWidget({
    super.key,
    required this.chatRoomData,
    required this.roomId,
  });

  final dynamic chatRoomData;
  final String? roomId;

  @override
  State<ChatRoomInfoComponentWidget> createState() =>
      _ChatRoomInfoComponentWidgetState();
}

class _ChatRoomInfoComponentWidgetState
    extends State<ChatRoomInfoComponentWidget> {
  late ChatRoomInfoComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRoomInfoComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.userUids = functions
          .keys(getJsonField(
            widget.chatRoomData,
            r'''$.users''',
          ))
          .toList()
          .cast<String>();
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: FlutterFlowTheme.of(context).secondaryBackground,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 60.0,
                fillColor: Colors.transparent,
                icon: Icon(
                  Icons.arrow_back,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 24.0,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                custom_widgets.ChatRoomIcon(
                  width: 100.0,
                  height: 100.0,
                  roomId: widget.roomId!,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getJsonField(
                            widget.chatRoomData,
                            r'''$.name''',
                          ).toString(),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'Inter Tight',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Text(
                          getJsonField(
                            widget.chatRoomData,
                            r'''$.description''',
                          ).toString(),
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ].divide(const SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '0cfglr7y' /* Members */,
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final masterUserUid = getJsonField(
                        widget.chatRoomData,
                        r'''$.masterUsers''',
                      ).toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(masterUserUid.length,
                            (masterUserUidIndex) {
                          final masterUserUidItem =
                              masterUserUid[masterUserUidIndex];
                          return ChatMembersListTileWidget(
                            key: Key(
                                'Key946_${masterUserUidIndex}_of_${masterUserUid.length}'),
                            uid: masterUserUidItem.toString(),
                          );
                        }).divide(const SizedBox(height: 16.0)),
                      );
                    },
                  ),
                  Builder(
                    builder: (context) {
                      final uid = _model.userUids.toList();

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: List.generate(uid.length, (uidIndex) {
                          final uidItem = uid[uidIndex];
                          return ChatMembersListTileWidget(
                            key: Key('Key75a_${uidIndex}_of_${uid.length}'),
                            uid: uidItem,
                          );
                        })
                            .divide(const SizedBox(height: 16.0))
                            .addToStart(const SizedBox(height: 16.0)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
