import '/backend/schema/enums/enums.dart';
import '/components/data/field/data_detail_content_component/data_detail_content_component_widget.dart';
import '/components/data/field/data_detail_title_component/data_detail_title_component_widget.dart';
import '/components/report_bottom_sheet_component/report_bottom_sheet_component_widget.dart';
import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'data_detail_component_model.dart';
export 'data_detail_component_model.dart';

class DataDetailComponentWidget extends StatefulWidget {
  const DataDetailComponentWidget({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.onDelete,
    required this.onReply,
    required this.onReport,
  });

  final dynamic data;
  final Future Function(dynamic data)? onUpdate;
  final Future Function()? onDelete;
  final Future Function(dynamic data)? onReply;
  final Future Function(dynamic data)? onReport;

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
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
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
                  size: 60.0,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wrapWithModel(
                      model: _model.userDisplayNameComponentModel,
                      updateCallback: () => safeSetState(() {}),
                      child: UserDisplayNameComponentWidget(
                        uid: getJsonField(
                          widget.data,
                          r'''$.uid''',
                        ).toString(),
                        fontSize: 14.0,
                      ),
                    ),
                    wrapWithModel(
                      model: _model.shortDateTimeComponentModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ShortDateTimeComponentWidget(
                        timestamp: getJsonField(
                          widget.data,
                          r'''$.createdAt''',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: wrapWithModel(
              model: _model.dataDetailTitleComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: DataDetailTitleComponentWidget(
                title: getJsonField(
                  _model.data,
                  r'''$.title''',
                ).toString(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
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
                    text: 'Edit',
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
                      await widget.onDelete?.call();
                    },
                    text: 'Delete',
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
                FFButtonWidget(
                  onPressed: () async {
                    await widget.onReply?.call(
                      _model.data!,
                    );
                  },
                  text: 'Reply',
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
                  text: _model.likeData ? 'Liked' : 'Like',
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
                if ((getJsonField(
                          _model.data,
                          r'''$.likeCount''',
                        ) !=
                        null) &&
                    (getJsonField(
                          _model.data,
                          r'''$.likeCount''',
                        ).toString() !=
                        '0'))
                  Text(
                    getJsonField(
                      _model.data,
                      r'''$.likeCount''',
                    ).toString(),
                    style: FlutterFlowTheme.of(context).labelSmall.override(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                  ),
                FFButtonWidget(
                  onPressed: () {
                    print('FollowButton pressed ...');
                  },
                  text: 'Follow',
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
                    print('BlockButton pressed ...');
                  },
                  text: 'Block',
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
                  text: 'Report',
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
              ],
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
