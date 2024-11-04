import '/components/data/data_create_component/data_create_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'post_create_screen_model.dart';
export 'post_create_screen_model.dart';

class PostCreateScreenWidget extends StatefulWidget {
  const PostCreateScreenWidget({
    super.key,
    required this.category,
  });

  final String? category;

  @override
  State<PostCreateScreenWidget> createState() => _PostCreateScreenWidgetState();
}

class _PostCreateScreenWidgetState extends State<PostCreateScreenWidget> {
  late PostCreateScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostCreateScreenModel());

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
            'Create post  in ${widget.category}',
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
          child: wrapWithModel(
            model: _model.dataCreateComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: DataCreateComponentWidget(
              category: widget.category!,
            ),
          ),
        ),
      ),
    );
  }
}
