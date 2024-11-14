import '/components/comment/comment_create_component/comment_create_component_widget.dart';
import '/components/comment/comment_list_tile_component/comment_list_tile_component_widget.dart';
import '/components/comment/comment_list_view_component/comment_list_view_component_widget.dart';
import '/components/data/data_detail_component/data_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'post_details_screen_copy_model.dart';
export 'post_details_screen_copy_model.dart';

class PostDetailsScreenCopyWidget extends StatefulWidget {
  const PostDetailsScreenCopyWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<PostDetailsScreenCopyWidget> createState() =>
      _PostDetailsScreenCopyWidgetState();
}

class _PostDetailsScreenCopyWidgetState
    extends State<PostDetailsScreenCopyWidget> {
  late PostDetailsScreenCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostDetailsScreenCopyModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            FFLocalizations.of(context).getText(
              '8bax65wg' /* Post Details */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: wrapWithModel(
                    model: _model.dataDetailComponentModel,
                    updateCallback: () => safeSetState(() {}),
                    child: DataDetailComponentWidget(
                      data: widget.data!,
                      blockCondition: null,
                      onUpdate: (data) async {
                        context.pushNamed(
                          'PostUpdateScreen',
                          queryParameters: {
                            'data': serializeParam(
                              data,
                              ParamType.JSON,
                            ),
                          }.withoutNulls,
                        );
                      },
                      onReply: (data) async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          useSafeArea: true,
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: CommentCreateComponentWidget(
                                  dataOrComment: data,
                                  onCancel: () async {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                    ),
                  ),
                ),
                wrapWithModel(
                  model: _model.commentListViewComponentModel,
                  updateCallback: () => safeSetState(() {}),
                  child: CommentListViewComponentWidget(
                    dataKey: getJsonField(
                      widget.data,
                      r'''$.key''',
                    ).toString(),
                    shrinkWrap: true,
                    builder: (dynamic comment) =>
                        CommentListTileComponentWidget(
                      comment: comment,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
