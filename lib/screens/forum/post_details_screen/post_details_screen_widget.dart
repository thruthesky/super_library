import '/components/comment/comment_create_component/comment_create_component_widget.dart';
import '/components/comment/comment_list_tile_component/comment_list_tile_component_widget.dart';
import '/components/data/data_detail_component/data_detail_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'post_details_screen_model.dart';
export 'post_details_screen_model.dart';

class PostDetailsScreenWidget extends StatefulWidget {
  const PostDetailsScreenWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<PostDetailsScreenWidget> createState() =>
      _PostDetailsScreenWidgetState();
}

class _PostDetailsScreenWidgetState extends State<PostDetailsScreenWidget> {
  late PostDetailsScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostDetailsScreenModel());

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
            'Post Details',
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
                      onUpdate: () async {
                        context.pushNamed(
                          'PostUpdateScreen',
                          queryParameters: {
                            'data': serializeParam(
                              widget.data,
                              ParamType.JSON,
                            ),
                          }.withoutNulls,
                        );
                      },
                      onDelete: () async {
                        await actions.deleteData(
                          context,
                          getJsonField(
                            widget.data,
                            r'''$.key''',
                          ).toString(),
                          () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'This post has deleted',
                                  style: TextStyle(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          },
                          (error) async {},
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'This post has deleted',
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                            duration: const Duration(milliseconds: 4000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                          ),
                        );
                      },
                      onReply: () async {
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
                                  data: widget.data!,
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                      },
                    ),
                  ),
                ),
                custom_widgets.CommentListView(
                  width: double.infinity,
                  height: 400.0,
                  dataKey: getJsonField(
                    widget.data,
                    r'''$.key''',
                  ).toString(),
                  shrinkWrap: true,
                  builder: (dynamic data) => CommentListTileComponentWidget(
                    comment: data,
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
