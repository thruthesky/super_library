import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'chat_room_edit_component_model.dart';
export 'chat_room_edit_component_model.dart';

class ChatRoomEditComponentWidget extends StatefulWidget {
  const ChatRoomEditComponentWidget({
    super.key,
    required this.uidOrRoomId,
    required this.room,
  });

  final String? uidOrRoomId;
  final dynamic room;

  @override
  State<ChatRoomEditComponentWidget> createState() =>
      _ChatRoomEditComponentWidgetState();
}

class _ChatRoomEditComponentWidgetState
    extends State<ChatRoomEditComponentWidget> {
  late ChatRoomEditComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRoomEditComponentModel());

    _model.nameTextController1 ??= TextEditingController();
    _model.nameFocusNode1 ??= FocusNode();

    _model.nameTextController2 ??= TextEditingController(
        text: getJsonField(
      widget.room,
      r'''$.name''',
    ).toString().toString());
    _model.nameFocusNode2 ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController(
        text: getJsonField(
      widget.room,
      r'''$.description''',
    ).toString().toString());
    _model.descriptionFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 0.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '1p9ssitl' /* Edit Chat Room */,
                      ),
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Inter Tight',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24.0),
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(24.0),
                                    border: Border.all(
                                      color: const Color(0xE857636C),
                                      width: 1.6,
                                    ),
                                  ),
                                  child: Builder(
                                    builder: (context) {
                                      if (getJsonField(
                                            widget.room,
                                            r'''$.iconUrl''',
                                          ) !=
                                          null) {
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                            child: CachedNetworkImage(
                                              fadeInDuration:
                                                  const Duration(milliseconds: 500),
                                              fadeOutDuration:
                                                  const Duration(milliseconds: 500),
                                              imageUrl: getJsonField(
                                                widget.room,
                                                r'''$.iconUrl''',
                                              ).toString(),
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Align(
                                          alignment:
                                              const AlignmentDirectional(0.0, 0.0),
                                          child: Icon(
                                            Icons.groups_3,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 32.0,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.3, 1.3),
                            child: FlutterFlowIconButton(
                              borderColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              borderRadius: 16.0,
                              borderWidth: 1.0,
                              buttonSize: 40.0,
                              fillColor: Colors.transparent,
                              icon: Icon(
                                Icons.camera_alt,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 24.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.nameTextController1,
                      focusNode: _model.nameFocusNode1,
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
                          'au3iovsr' /* Chat Room Icon Url */,
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
                      validator: _model.nameTextController1Validator
                          .asValidator(context),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.nameTextController2,
                      focusNode: _model.nameFocusNode2,
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
                          'irb9yyi6' /* Name */,
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
                      validator: _model.nameTextController2Validator
                          .asValidator(context),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _model.descriptionTextController,
                      focusNode: _model.descriptionFocusNode,
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
                          '7xs6bxvb' /* Description */,
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
                      maxLines: 4,
                      minLines: 4,
                      cursorColor: FlutterFlowTheme.of(context).primaryText,
                      validator: _model.descriptionTextControllerValidator
                          .asValidator(context),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: const Color(0xE857636C),
                          width: 1.6,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Theme(
                          data: ThemeData(
                            checkboxTheme: const CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          child: CheckboxListTile(
                            value: _model.openValue ??= getJsonField(
                              widget.room,
                              r'''$.open''',
                            ),
                            onChanged: (newValue) async {
                              safeSetState(() => _model.openValue = newValue!);
                            },
                            title: Text(
                              FFLocalizations.of(context).getText(
                                'ycg4c91y' /* Open */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            subtitle: Text(
                              FFLocalizations.of(context).getText(
                                '4wqovkox' /* Anyone can enter */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor: FlutterFlowTheme.of(context).info,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(
                          color: const Color(0xE857636C),
                          width: 1.6,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Theme(
                          data: ThemeData(
                            checkboxTheme: const CheckboxThemeData(
                              visualDensity: VisualDensity.compact,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            unselectedWidgetColor:
                                FlutterFlowTheme.of(context).alternate,
                          ),
                          child: CheckboxListTile(
                            value: _model.inviteValue ??= getJsonField(
                              widget.room,
                              r'''$.allMembersCanInvite''',
                            ),
                            onChanged: (newValue) async {
                              safeSetState(
                                  () => _model.inviteValue = newValue!);
                            },
                            title: Text(
                              FFLocalizations.of(context).getText(
                                'jox7rmng' /* Invite */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Inter Tight',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            subtitle: Text(
                              FFLocalizations.of(context).getText(
                                'ltkzj57e' /* Anyone can invite others */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            tileColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            activeColor: FlutterFlowTheme.of(context).primary,
                            checkColor: FlutterFlowTheme.of(context).info,
                            dense: false,
                            controlAffinity: ListTileControlAffinity.trailing,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            'ou3lmakv' /* Cancel */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            await actions.updateChatRoom(
                              widget.uidOrRoomId,
                              _model.nameTextController1.text,
                              _model.descriptionTextController.text,
                              null,
                              _model.openValue,
                              _model.inviteValue,
                            );
                            Navigator.pop(context);
                          },
                          text: FFLocalizations.of(context).getText(
                            'hy3wagbp' /* Update */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
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
                      ),
                    ],
                  ),
                ].divide(const SizedBox(height: 24.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
