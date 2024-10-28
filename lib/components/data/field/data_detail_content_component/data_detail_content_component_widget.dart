import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'data_detail_content_component_model.dart';
export 'data_detail_content_component_model.dart';

class DataDetailContentComponentWidget extends StatefulWidget {
  const DataDetailContentComponentWidget({
    super.key,
    required this.content,
  });

  final String? content;

  @override
  State<DataDetailContentComponentWidget> createState() =>
      _DataDetailContentComponentWidgetState();
}

class _DataDetailContentComponentWidgetState
    extends State<DataDetailContentComponentWidget> {
  late DataDetailContentComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataDetailContentComponentModel());

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
      widget.content!,
      style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Inter',
            letterSpacing: 0.0,
          ),
    );
  }
}
