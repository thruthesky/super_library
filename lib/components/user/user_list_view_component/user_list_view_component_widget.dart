import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'user_list_view_component_model.dart';
export 'user_list_view_component_model.dart';

class UserListViewComponentWidget extends StatefulWidget {
  const UserListViewComponentWidget({
    super.key,
    bool? horizontalScroll,
    bool? reverse,
    required this.builder,
  })  : horizontalScroll = horizontalScroll ?? false,
        reverse = reverse ?? false;

  final bool horizontalScroll;
  final bool reverse;
  final Widget Function(dynamic data)? builder;

  @override
  State<UserListViewComponentWidget> createState() =>
      _UserListViewComponentWidgetState();
}

class _UserListViewComponentWidgetState
    extends State<UserListViewComponentWidget> {
  late UserListViewComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserListViewComponentModel());

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
          custom_widgets.UserListView(
            width: 1.0,
            height: 1.0,
            horizontalScroll: widget.horizontalScroll,
            reverse: widget.reverse,
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
