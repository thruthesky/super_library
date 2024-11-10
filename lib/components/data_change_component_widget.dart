import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'data_change_component_model.dart';
export 'data_change_component_model.dart';

class DataChangeComponentWidget extends StatefulWidget {
  const DataChangeComponentWidget({
    super.key,
    required this.dataKey,
    this.field,
    this.initialData,
    required this.builder,
  });

  final String? dataKey;
  final String? field;
  final dynamic initialData;
  final Widget Function(dynamic data)? builder;

  @override
  State<DataChangeComponentWidget> createState() =>
      _DataChangeComponentWidgetState();
}

class _DataChangeComponentWidgetState extends State<DataChangeComponentWidget> {
  late DataChangeComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataChangeComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        custom_widgets.DataChange(
          width: 1.0,
          height: 1.0,
          dataKey: widget.dataKey!,
          field: widget.field != null && widget.field != ''
              ? widget.field
              : null,
          initialData: widget.initialData!,
          builder: (dynamic data) => widget.builder!(
            data,
          ),
        ),
        if (false)
          Builder(builder: (_) {
            return widget.builder!(
              widget.initialData!,
            );
          }),
      ],
    );
  }
}
