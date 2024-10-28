import '/components/data/field/data_detail_content_component/data_detail_content_component_widget.dart';
import '/components/data/field/data_detail_title_component/data_detail_title_component_widget.dart';
import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'data_detail_component_model.dart';
export 'data_detail_component_model.dart';

class DataDetailComponentWidget extends StatefulWidget {
  const DataDetailComponentWidget({
    super.key,
    required this.data,
    required this.onUpdate,
    required this.onDelete,
    required this.onReply,
  });

  final dynamic data;
  final Future Function()? onUpdate;
  final Future Function()? onDelete;
  final Future Function()? onReply;

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
              SizedBox(
                width: 60.0,
                height: 60.0,
                child: custom_widgets.UserAvatar(
                  width: 60.0,
                  height: 60.0,
                  uid: getJsonField(
                    widget.data,
                    r'''$.uid''',
                  ).toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    custom_widgets.UserDisplayName(
                      width: 100.0,
                      height: 24.0,
                      uid: getJsonField(
                        widget.data,
                        r'''$.uid''',
                      ).toString(),
                      nameIfEmpty: '...',
                      nameIfBlockedUser: 'Blocked User',
                      fontSize: 14.0,
                      fontColor: FlutterFlowTheme.of(context).secondaryText,
                    ),
                    wrapWithModel(
                      model: _model.shortDateTimeComponentModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ShortDateTimeComponentWidget(
                        stamp: getJsonField(
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
            child: SizedBox(
              width: double.infinity,
              height: 26.0,
              child: custom_widgets.DataChange(
                width: double.infinity,
                height: 26.0,
                dataKey: getJsonField(
                  widget.data,
                  r'''$.key''',
                ).toString(),
                field: 'title',
                initialData: getJsonField(
                  widget.data,
                  r'''$.title''',
                ),
                builder: (dynamic data) => DataDetailTitleComponentWidget(
                  title: data.toString(),
                ),
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
                child: SizedBox(
                  width: double.infinity,
                  height: 26.0,
                  child: custom_widgets.DataChange(
                    width: double.infinity,
                    height: 26.0,
                    dataKey: getJsonField(
                      widget.data,
                      r'''$.key''',
                    ).toString(),
                    field: 'content',
                    initialData: getJsonField(
                      widget.data,
                      r'''$.content''',
                    ),
                    builder: (dynamic data) => DataDetailContentComponentWidget(
                      content: data.toString(),
                    ),
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
                FFButtonWidget(
                  onPressed: () async {
                    await widget.onUpdate?.call();
                  },
                  text: 'Edit',
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
                    await widget.onReply?.call();
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
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Like',
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
                    print('Button pressed ...');
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
                    print('Button pressed ...');
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
                  onPressed: () {
                    print('Button pressed ...');
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
        ],
      ),
    );
  }
}
