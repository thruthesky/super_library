import '/components/data/data_list_tile_component/data_list_tile_component_widget.dart';
import '/components/data/data_list_view_component/data_list_view_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'post_list_screen_model.dart';
export 'post_list_screen_model.dart';

class PostListScreenWidget extends StatefulWidget {
  const PostListScreenWidget({
    super.key,
    required this.category,
  });

  final String? category;

  @override
  State<PostListScreenWidget> createState() => _PostListScreenWidgetState();
}

class _PostListScreenWidgetState extends State<PostListScreenWidget> {
  late PostListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostListScreenModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          title: Text(
            valueOrDefault<String>(
              widget.category,
              '...',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 40.0,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
              onPressed: () async {
                context.pushNamed(
                  'PostCreateScreen',
                  queryParameters: {
                    'category': serializeParam(
                      widget.category,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
            ),
            Container(
              width: 24.0,
              height: 24.0,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
            child: wrapWithModel(
              model: _model.dataListViewComponentModel,
              updateCallback: () => safeSetState(() {}),
              child: DataListViewComponentWidget(
                category: widget.category!,
                builder: (dynamic data) => DataListTileComponentWidget(
                  data: data,
                  onTap: () async {
                    context.pushNamed(
                      'PostDetailsScreen',
                      queryParameters: {
                        'data': serializeParam(
                          FFAppState().dataListTileComponentActionParameter,
                          ParamType.JSON,
                        ),
                      }.withoutNulls,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
