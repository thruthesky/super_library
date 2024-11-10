import '/backend/schema/enums/enums.dart';
import '/components/comment/comment_create_component/comment_create_component_widget.dart';
import '/components/comment/comment_update_component/comment_update_component_widget.dart';
import '/components/report_bottom_sheet_component/report_bottom_sheet_component_widget.dart';
import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'comment_list_tile_component_model.dart';
export 'comment_list_tile_component_model.dart';

class CommentListTileComponentWidget extends StatefulWidget {
  const CommentListTileComponentWidget({
    super.key,
    required this.comment,
    this.blockCondition,
  });

  final dynamic comment;
  final bool? blockCondition;

  @override
  State<CommentListTileComponentWidget> createState() =>
      _CommentListTileComponentWidgetState();
}

class _CommentListTileComponentWidgetState
    extends State<CommentListTileComponentWidget> {
  late CommentListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentListTileComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.likeExist(
        getJsonField(
          widget.comment,
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
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          valueOrDefault<double>(
            functions.depth(getJsonField(
              widget.comment,
              r'''$.depth''',
            )),
            0.0,
          ),
          12.0,
          24.0,
          12.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  wrapWithModel(
                    model: _model.userAvatarComponentModel,
                    updateCallback: () => safeSetState(() {}),
                    child: UserAvatarComponentWidget(
                      uid: getJsonField(
                        widget.comment,
                        r'''$.uid''',
                      ).toString(),
                      size: 52.0,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          wrapWithModel(
                            model: _model.shortDateTimeComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: ShortDateTimeComponentWidget(
                              timestamp: getJsonField(
                                widget.comment,
                                r'''$.createdAt''',
                              ),
                            ),
                          ),
                          wrapWithModel(
                            model: _model.userDisplayNameComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: UserDisplayNameComponentWidget(
                              uid: getJsonField(
                                widget.comment,
                                r'''$.uid''',
                              ).toString(),
                            ),
                          ),
                          Text(
                            getJsonField(
                              widget.comment,
                              r'''$.key''',
                            ).toString(),
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    getJsonField(
                      widget.comment,
                      r'''$.content''',
                    ).toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
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
                  FFButtonWidget(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.viewInsetsOf(context),
                            child: CommentCreateComponentWidget(
                              dataOrComment: widget.comment!,
                              onCancel: () async {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    },
                    text: FFLocalizations.of(context).getText(
                      'y5z9xduo' /* Reply */,
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
                  if (getJsonField(
                        widget.comment,
                        r'''$.isMine''',
                      ) &&
                      !getJsonField(
                        widget.comment,
                        r'''$.deleted''',
                      ))
                    FFButtonWidget(
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: CommentUpdateComponentWidget(
                                comment: widget.comment!,
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                      text: FFLocalizations.of(context).getText(
                        'end7bh91' /* Edit */,
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
                        widget.comment,
                        r'''$.isMine''',
                      ) &&
                      !getJsonField(
                        widget.comment,
                        r'''$.deleted''',
                      ))
                    FFButtonWidget(
                      onPressed: () async {
                        var confirmDialogResponse = await showDialog<bool>(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: const Text('Delete comment'),
                                  content: const Text(
                                      'Are you sure you want to delete this comment?'),
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
                          await actions.deleteComment(
                            context,
                            getJsonField(
                              widget.comment,
                              r'''$.key''',
                            ).toString(),
                            () async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Comment has been deleted',
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
                        'tdty4uy7' /* Delete */,
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
                  FFButtonWidget(
                    onPressed: () async {
                      await actions.like(
                        getJsonField(
                          widget.comment,
                          r'''$.path''',
                        ).toString(),
                        (value) async {
                          _model.likeData = value;
                          safeSetState(() {});
                        },
                        (error) async {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                error,
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: const Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        },
                      );
                    },
                    text:
                        '${_model.likeData ? 'Liked' : 'Like'}${(int? likeCount) {
                      return likeCount != null && likeCount > 0;
                    }(getJsonField(
                      widget.comment,
                      r'''$.likeCount''',
                    )) ? ' ${getJsonField(
                            widget.comment,
                            r'''$.likeCount''',
                          ).toString()}' : ''}',
                    options: FFButtonOptions(
                      height: 34.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
                                                'Are you sure you want to unblock this user'),
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
                                    widget.comment,
                                    r'''$.uid''',
                                  ).toString(),
                                );

                                safeSetState(() {});
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'knis7vih' /* Unblock */,
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
                                            title: const Text('Blocking user'),
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
                                    widget.comment,
                                    r'''$.uid''',
                                  ).toString(),
                                );

                                safeSetState(() {});
                              }
                            },
                            text: FFLocalizations.of(context).getText(
                              'mp9ycf3g' /* Block */,
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
                        ReportType.comment.name,
                        getJsonField(
                          widget.comment,
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
                                type: ReportType.comment.name,
                                id: getJsonField(
                                  widget.comment,
                                  r'''$.key''',
                                ).toString(),
                                reporteeUid: getJsonField(
                                  widget.comment,
                                  r'''$.uid''',
                                ).toString(),
                                summary: getJsonField(
                                  widget.comment,
                                  r'''$.content''',
                                ).toString(),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      }

                      safeSetState(() {});
                    },
                    text: FFLocalizations.of(context).getText(
                      'zq23c5au' /* Report */,
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
          ],
        ),
      ),
    );
  }
}
