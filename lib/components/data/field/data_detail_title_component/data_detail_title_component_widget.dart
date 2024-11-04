import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'data_detail_title_component_model.dart';
export 'data_detail_title_component_model.dart';

class DataDetailTitleComponentWidget extends StatefulWidget {
  const DataDetailTitleComponentWidget({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  State<DataDetailTitleComponentWidget> createState() =>
      _DataDetailTitleComponentWidgetState();
}

class _DataDetailTitleComponentWidgetState
    extends State<DataDetailTitleComponentWidget> {
  late DataDetailTitleComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataDetailTitleComponentModel());

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
      widget.title!,
      style: FlutterFlowTheme.of(context).titleMedium.override(
            fontFamily: 'Inter Tight',
            letterSpacing: 0.0,
          ),
    );
  }
}
