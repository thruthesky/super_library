import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'data_list_view_component_model.dart';
export 'data_list_view_component_model.dart';

class DataListViewComponentWidget extends StatefulWidget {
  const DataListViewComponentWidget({
    super.key,
    required this.category,
    required this.builder,
  });

  final String? category;
  final Widget Function(dynamic data)? builder;

  @override
  State<DataListViewComponentWidget> createState() =>
      _DataListViewComponentWidgetState();
}

class _DataListViewComponentWidgetState
    extends State<DataListViewComponentWidget> {
  late DataListViewComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataListViewComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          custom_widgets.DataListView(
            width: 1.0,
            height: 1.0,
            category: widget.category!,
            builder: (dynamic data) => widget.builder!(
              data,
            ),
          ),
          if (false)
            Builder(
              builder: (context) {
                final index = functions.generateEmptyList(20).toList();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(index.length, (indexIndex) {
                    final indexItem = index[indexIndex];
                    return Builder(builder: (_) {
                      return widget.builder!(
                        <String, dynamic>{
                          'createdAt':
                              random_data.randomInteger(10000000, 19000000),
                          'title': 'This is the data title',
                          'content': 'This is the data content',
                          'uid': 'abcdef',
                        },
                      );
                    });
                  }),
                );
              },
            ),
        ],
      ),
    );
  }
}
