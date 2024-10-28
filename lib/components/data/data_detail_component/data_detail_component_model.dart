import '/components/utility/short_date_time_component/short_date_time_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'data_detail_component_widget.dart' show DataDetailComponentWidget;
import 'package:flutter/material.dart';

class DataDetailComponentModel
    extends FlutterFlowModel<DataDetailComponentWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ShortDateTimeComponent component.
  late ShortDateTimeComponentModel shortDateTimeComponentModel;

  @override
  void initState(BuildContext context) {
    shortDateTimeComponentModel =
        createModel(context, () => ShortDateTimeComponentModel());
  }

  @override
  void dispose() {
    shortDateTimeComponentModel.dispose();
  }
}
