import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'comment_list_view_component_model.dart';
export 'comment_list_view_component_model.dart';

class CommentListViewComponentWidget extends StatefulWidget {
  const CommentListViewComponentWidget({
    super.key,
    required this.dataKey,
    required this.builder,
    this.shrinkWrap,
  });

  final String? dataKey;
  final Widget Function(dynamic comment)? builder;
  final bool? shrinkWrap;

  @override
  State<CommentListViewComponentWidget> createState() =>
      _CommentListViewComponentWidgetState();
}

class _CommentListViewComponentWidgetState
    extends State<CommentListViewComponentWidget> {
  late CommentListViewComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentListViewComponentModel());

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
          custom_widgets.CommentListView(
            width: 1.0,
            height: 1.0,
            dataKey: widget.dataKey!,
            shrinkWrap: widget.shrinkWrap,
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
                        <String, dynamic>{},
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
