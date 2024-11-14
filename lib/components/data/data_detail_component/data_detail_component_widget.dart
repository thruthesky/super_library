import '/backend/schema/enums/enums.dart';
import '/components/data/field/data_detail_content_component/data_detail_content_component_widget.dart';
import '/components/data/field/data_detail_title_component/data_detail_title_component_widget.dart';
import '/components/report_bottom_sheet_component/report_bottom_sheet_component_widget.dart';
import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'data_detail_component_model.dart';
export 'data_detail_component_model.dart';

class DataDetailComponentWidget extends StatefulWidget {
  const DataDetailComponentWidget({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.onReply,
    this.blockCondition,
  });

  final dynamic data;
  final Future Function(dynamic data)? onUpdate;
  final Future Function(dynamic data)? onReply;
  final bool? blockCondition;

  @override
  State<DataDetailComponentWidget> createState() =>
      _DataDetailComponentWidgetState();
}

class _DataDetailComponentWidgetState extends State<DataDetailComponentWidget> {
  late DataDetailComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataDetailComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.data = widget.data;
      safeSetState(() {});
      await actions.likeExist(
        getJsonField(
          widget.data,
          r'''$.path''',
        ).toString().toString(),
        (value) async {
          _model.likeData = value;
          safeSetState(() {});
        },
      );
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                wrapWithModel(
                  model: _model.userAvatarComponentModel,
                  updateCallback: () => safeSetState(() {}),
                  child: UserAvatarComponentWidget(
                    uid: getJsonField(
                      widget.data,
                      r'''$.uid''',
                    ).toString(),
                    size: 48.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: wrapWithModel(
                    model: _model.userDisplayNameComponentModel,
                    updateCallback: () => safeSetState(() {}),
                    child: UserDisplayNameComponentWidget(
                      uid: getJsonField(
                        widget.data,
                        r'''$.uid''',
                      ).toString(),
                      fontSize: 16.0,
                      fontColor: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                  child: Text(
                    dateTimeFormat(
                      "yMd",
                      functions.dateTimeOf(getJsonField(
                        widget.data,
                        r'''$.createdAt''',
                      )),
                      locale: FFLocalizations.of(context).languageCode,
                    ),
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
                if (getJsonField(
                  _model.data,
                  r'''$.isMine''',
                ))
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).primaryText,
                        borderRadius: 16.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.more_vert,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          _model.moreOptions = !_model.moreOptions;
                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (_model.moreOptions)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  if ((_model.data != null) &&
                      getJsonField(
                        _model.data,
                        r'''$.isMine''',
                      ) &&
                      !getJsonField(
                        _model.data,
                        r'''$.deleted''',
                      ))
                    FFButtonWidget(
                      onPressed: () async {
                        await widget.onUpdate?.call(
                          _model.data!,
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'opth2ehx' /* Edit */,
                      ),
                      options: FFButtonOptions(
                        height: 34.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                  if (getJsonField(
                    _model.data,
                    r'''$.isMine''',
                  ))
                    FFButtonWidget(
                      onPressed: () async {
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Deleting  post'),
                                  content: const Text(
                                      'Are you sure you want to delete this post?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: const Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          await actions.deleteData(
                            context,
                            getJsonField(
                              widget.data,
                              r'''$.key''',
                            ).toString(),
                            () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'This post has deleted',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            },
                            (error) async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    error,
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            },
                          );
                        }
                      },
                      text: FFLocalizations.of(context).getText(
                        'xtkghy0m' /* Delete */,
                      ),
                      options: FFButtonOptions(
                        height: 34.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: Colors.transparent,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
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
                  if (widget.blockCondition != null)
                    Builder(
                      builder: (context) {
                        if (widget.blockCondition ?? false) {
                          return FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Unblocking user'),
                                            content: const Text(
                                                'Are you sure you want to unblock this user?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                await actions.unblockUser(
                                  getJsonField(
                                    widget.data,
                                    r'''$.uid''',
                                  ).toString(),
                                );

                                safeSetState(() {});
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'qo47av0o' /* Unblock */,
                            ),
                            options: FFButtonOptions(
                              height: 34.0,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 1.6,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          );
                        } else {
                          return FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: const Text('Blocking User'),
                                            content: const Text(
                                                'Are you sure you want to block this user?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: const Text('Confirm'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                await actions.blockUser(
                                  getJsonField(
                                    widget.data,
                                    r'''$.uid''',
                                  ).toString(),
                                );

                                safeSetState(() {});
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'm8vsumja' /* Block */,
                            ),
                            options: FFButtonOptions(
                              height: 34.0,
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
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                width: 1.6,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          );
                        }
                      },
                    ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.isReportExist = await actions.reportExists(
                        ReportType.post.name,
                        getJsonField(
                          widget.data,
                          r'''$.key''',
                        ).toString(),
                      );
                      if (_model.isReportExist!) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Report already exist',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      } else {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: ReportBottomSheetComponentWidget(
                                type: ReportType.post.name,
                                id: getJsonField(
                                  widget.data,
                                  r'''$.key''',
                                ).toString(),
                                reporteeUid: getJsonField(
                                  widget.data,
                                  r'''$.uid''',
                                ).toString(),
                                summary: (String title, String content) {
                                  return "$title ${content.length > 128 ? content.substring(0, 128) : content}";
                                }(
                                    getJsonField(
                                      _model.data,
                                      r'''$.title''',
                                    ).toString(),
                                    getJsonField(
                                      _model.data,
                                      r'''$.content''',
                                    ).toString()),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'mnz45tn4' /* Report */,
                    ),
                    options: FFButtonOptions(
                      height: 34.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      iconPadding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: Colors.transparent,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
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
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: Colors.transparent,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24.0),
                    border: Border.all(
                      color: const Color(0xE857636C),
                      width: 1.6,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.dataDetailTitleComponentModel,
                          updateCallback: () => safeSetState(() {}),
                          child: DataDetailTitleComponentWidget(
                            title: getJsonField(
                              _model.data,
                              r'''$.title''',
                            ).toString(),
                          ),
                        ),
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 16.0, 0.0, 0.0),
                            child: wrapWithModel(
                              model: _model.dataDetailContentComponentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: DataDetailContentComponentWidget(
                                content: getJsonField(
                                  _model.data,
                                  r'''$.content''',
                                ).toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    await actions.like(
                      getJsonField(
                        widget.data,
                        r'''$.path''',
                      ).toString(),
                      (value) async {
                        _model.likeData = value;
                        safeSetState(() {});
                        _model.likeCountOutput = await actions.readDataField(
                          context,
                          getJsonField(
                            widget.data,
                            r'''$.key''',
                          ).toString(),
                          'likeCount',
                        );
                      },
                      (error) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              error,
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      },
                    );

                    safeSetState(() {});
                  },
                  text: '${_model.likeData ? 'Liked' : 'Like'}${(getJsonField(
                        _model.data,
                        r'''$.likeCount''',
                      ) != null) && (getJsonField(
                        _model.data,
                        r'''$.likeCount''',
                      ).toString() != '0') ? ' ${getJsonField(
                      _model.data,
                      r'''$.likeCount''',
                    ).toString()}' : ''}',
                  options: FFButtonOptions(
                    height: 34.0,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                FFButtonWidget(
                  onPressed: () async {
                    await widget.onReply?.call(
                      _model.data!,
                    );
                  },
                  text: FFLocalizations.of(context).getText(
                    'lql2cwt0' /* Reply */,
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
                FFButtonWidget(
                  onPressed: () {
                    print('FollowButton pressed ...');
                  },
                  text: FFLocalizations.of(context).getText(
                    '42vwc8nx' /* Follow */,
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
              ].divide(const SizedBox(width: 8.0)),
            ),
          ),
          custom_widgets.DataChangeListener(
            width: 0.0,
            height: 0.0,
            path: getJsonField(
              widget.data,
              r'''$.path''',
            ).toString(),
            onChange: (data) async {
              _model.data = data;
              safeSetState(() {});
            },
          ),
        ],
      ),
    );
  }
}
