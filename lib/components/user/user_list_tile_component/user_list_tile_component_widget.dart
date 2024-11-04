import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'user_list_tile_component_model.dart';
export 'user_list_tile_component_model.dart';

class UserListTileComponentWidget extends StatefulWidget {
  const UserListTileComponentWidget({
    super.key,
    this.data,
    required this.onTap,
  });

  final dynamic data;
  final Future Function(String uid)? onTap;

  @override
  State<UserListTileComponentWidget> createState() =>
      _UserListTileComponentWidgetState();
}

class _UserListTileComponentWidgetState
    extends State<UserListTileComponentWidget> {
  late UserListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListTileComponentModel());

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
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          FFAppState().userListTileComponentActionParameter = widget.data!;
          await widget.onTap?.call(
            widget.data!.toString(),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            wrapWithModel(
              model: _model.userAvatarComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: UserAvatarComponentWidget(
                uid: getJsonField(
                  widget.data,
                  r'''$.uid''',
                ).toString(),
                size: 52.0,
                radius: 24.0,
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Text(
                        functions
                            .shortDateTimeOf(functions.dateTimeOf(getJsonField(
                          widget.data,
                          r'''$.createdAt''',
                        ))),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
