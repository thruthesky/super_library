import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'chat_room_invite_component_model.dart';
export 'chat_room_invite_component_model.dart';

class ChatRoomInviteComponentWidget extends StatefulWidget {
  const ChatRoomInviteComponentWidget({super.key});

  @override
  State<ChatRoomInviteComponentWidget> createState() =>
      _ChatRoomInviteComponentWidgetState();
}

class _ChatRoomInviteComponentWidgetState
    extends State<ChatRoomInviteComponentWidget> {
  late ChatRoomInviteComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRoomInviteComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

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
        mainAxisSize: MainAxisSize.min,
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
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'tjo4sy0r' /* Invite Users */,
                ),
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Inter Tight',
                      letterSpacing: 0.0,
                    ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 200.0,
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                        hintText: FFLocalizations.of(context).getText(
                          'ic862ajs' /* Input name of the user */,
                        ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primaryText,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Inter',
                            letterSpacing: 0.0,
                          ),
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ),
                FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: FFLocalizations.of(context).getText(
                    'drjme0xm' /* Search */,
                  ),
                  options: FFButtonOptions(
                    height: 34.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    iconPadding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Colors.transparent,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).secondaryText,
                      width: 1.6,
                    ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ].divide(const SizedBox(width: 17.0)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
