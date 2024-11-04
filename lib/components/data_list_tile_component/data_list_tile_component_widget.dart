import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        FFAppState().dataListTileComponentActionParameter = widget.data!;
        await widget.onTap?.call();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
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
                  size: 60.0,
                  radius: 28.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getJsonField(
                          widget.data,
                          r'''$.title''',
                        ).toString(),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Inter Tight',
                                  letterSpacing: 0.0,
                                ),
                      ),
                      wrapWithModel(
                        model: _model.userDisplayNameComponentModel,
                        updateCallback: () => safeSetState(() {}),
                        child: UserDisplayNameComponentWidget(
                          uid: getJsonField(
                            widget.data,
                            r'''$.uid''',
                          ).toString(),
                        ),
                      ),
                      Text(
                        functions
                            .dateTimeOf(getJsonField(
                              widget.data,
                              r'''$.createdAt''',
                            ))
                            .toString(),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
