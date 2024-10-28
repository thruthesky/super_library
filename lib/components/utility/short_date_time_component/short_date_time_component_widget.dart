import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'short_date_time_component_model.dart';
export 'short_date_time_component_model.dart';

class ShortDateTimeComponentWidget extends StatefulWidget {
  const ShortDateTimeComponentWidget({
    super.key,
    required this.stamp,
  });

  final int? stamp;

  @override
  State<ShortDateTimeComponentWidget> createState() =>
      _ShortDateTimeComponentWidgetState();
}

class _ShortDateTimeComponentWidgetState
    extends State<ShortDateTimeComponentWidget> {
  late ShortDateTimeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShortDateTimeComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      functions.shortDateTimeOf(widget.stamp!),
      style: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'Inter',
            letterSpacing: 0.0,
          ),
    );
  }
}
