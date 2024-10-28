import '/components/data/data_update_component/data_update_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'post_update_screen_model.dart';
export 'post_update_screen_model.dart';

class PostUpdateScreenWidget extends StatefulWidget {
  const PostUpdateScreenWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<PostUpdateScreenWidget> createState() => _PostUpdateScreenWidgetState();
}

class _PostUpdateScreenWidgetState extends State<PostUpdateScreenWidget> {
  late PostUpdateScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostUpdateScreenModel());

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
            'Update',
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
            model: _model.dataUpdateComponentModel,
            updateCallback: () => safeSetState(() {}),
            child: DataUpdateComponentWidget(
              data: widget.data,
            ),
          ),
        ),
      ),
    );
  }
}
