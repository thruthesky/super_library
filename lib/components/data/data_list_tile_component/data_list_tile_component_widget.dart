import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'data_list_tile_component_model.dart';
export 'data_list_tile_component_model.dart';

class DataListTileComponentWidget extends StatefulWidget {
  const DataListTileComponentWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  final dynamic data;
  final Future Function()? onTap;

  @override
  State<DataListTileComponentWidget> createState() =>
      _DataListTileComponentWidgetState();
}

class _DataListTileComponentWidgetState
    extends State<DataListTileComponentWidget> {
  late DataListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataListTileComponentModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (getJsonField(
            widget.data,
            r'''$.urls''',
          ) !=
          null) {
        _model.urls = getJsonField(
          widget.data,
          r'''$.urls''',
          true,
        )!
            .toList()
            .cast<String>();
        safeSetState(() {});
      }
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
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          FFAppState().dataListTileComponentActionParameter = widget.data!;
          await widget.onTap?.call();
        },
        child: Material(
          color: Colors.transparent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: const Color(0xE857636C),
                  width: 1.6,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                            size: 40.0,
                            radius: 100.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 0.0, 0.0),
                          child: wrapWithModel(
                            model: _model.userDisplayNameComponentModel,
                            updateCallback: () => safeSetState(() {}),
                            child: UserDisplayNameComponentWidget(
                              uid: getJsonField(
                                widget.data,
                                r'''$.uid''',
                              ).toString(),
                              fontSize: 14.0,
                              fontColor: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 0.0, 0.0),
                          child: Text(
                            dateTimeFormat(
                              "M/d h:mm a",
                              functions.dateTimeOf(getJsonField(
                                widget.data,
                                r'''$.createdAt''',
                              )),
                              locale: FFLocalizations.of(context)
                                      .languageShortCode ??
                                  FFLocalizations.of(context).languageCode,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .labelSmall
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w300,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 4.0, 0.0),
                                  child: Icon(
                                    Icons.thumb_up_off_alt,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 20.0,
                                  ),
                                ),
                                Text(
                                  getJsonField(
                                    widget.data,
                                    r'''$.likeCount''',
                                  ).toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_model.urls.isNotEmpty)
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: CachedNetworkImage(
                                  fadeInDuration: const Duration(milliseconds: 500),
                                  fadeOutDuration: const Duration(milliseconds: 500),
                                  imageUrl: _model.urls.first,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 16.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getJsonField(
                                      widget.data,
                                      r'''$.title''',
                                    ).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Inter Tight',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  Text(
                                    getJsonField(
                                      widget.data,
                                      r'''$.content''',
                                    ).toString().maybeHandleOverflow(
                                          maxChars: 64,
                                        ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Inter',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                  ),
                                ].divide(const SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
