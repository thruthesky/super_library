import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'user_display_name_component_model.dart';
export 'user_display_name_component_model.dart';

class UserDisplayNameComponentWidget extends StatefulWidget {
  const UserDisplayNameComponentWidget({
    super.key,
    required this.uid,
    this.fontSize,
    this.fontColor,
  });

  final String? uid;
  final double? fontSize;
  final Color? fontColor;

  @override
  State<UserDisplayNameComponentWidget> createState() =>
      _UserDisplayNameComponentWidgetState();
}

class _UserDisplayNameComponentWidgetState
    extends State<UserDisplayNameComponentWidget> {
  late UserDisplayNameComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserDisplayNameComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            custom_widgets.UserDisplayName(
              width: 1.0,
              height: 1.0,
              uid: widget.uid!,
              nameIfEmpty: '...',
              nameIfBlockedUser: 'Blocked User',
              fontSize: widget.fontSize,
              fontColor: widget.fontColor,
            ),
            if (false)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Text(
                  '[Display Name]',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        color: widget.fontColor,
                        fontSize: widget.fontSize,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
