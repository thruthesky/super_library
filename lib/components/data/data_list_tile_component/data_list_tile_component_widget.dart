import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'data_list_tile_component_model.dart';
export 'data_list_tile_component_model.dart';

class DataListTileComponentWidget extends StatefulWidget {
  const DataListTileComponentWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

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
        context.pushNamed(
          'PostDetailsScreen',
          queryParameters: {
            'data': serializeParam(
              widget.data,
              ParamType.JSON,
            ),
          }.withoutNulls,
        );
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
                  radius: 22.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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
                      custom_widgets.UserDisplayName(
                        width: 200.0,
                        height: 32.0,
                        uid: getJsonField(
                          widget.data,
                          r'''$.uid''',
                        ).toString(),
                        nameIfEmpty: '...',
                        nameIfBlockedUser: 'Blocked User',
                        fontSize: 14.0,
                      ),
                      Text(
                        functions.shortDateTimeOf(getJsonField(
                          widget.data,
                          r'''$.createdAt''',
                        )),
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
