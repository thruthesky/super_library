import '/components/user/user_list_tile_component/user_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'feed_list_tile_component_model.dart';
export 'feed_list_tile_component_model.dart';

class FeedListTileComponentWidget extends StatefulWidget {
  const FeedListTileComponentWidget({
    super.key,
    required this.data,
  });

  final dynamic data;

  @override
  State<FeedListTileComponentWidget> createState() =>
      _FeedListTileComponentWidgetState();
}

class _FeedListTileComponentWidgetState
    extends State<FeedListTileComponentWidget> {
  late FeedListTileComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedListTileComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: wrapWithModel(
                model: _model.userListTileComponentModel,
                updateCallback: () => safeSetState(() {}),
                child: UserListTileComponentWidget(
                  data: widget.data,
                  onTap: (uid) async {},
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
          child: Text(
            getJsonField(
              widget.data,
              r'''$.title''',
            ).toString(),
            style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 0.0, 0.0),
          child: Text(
            getJsonField(
              widget.data,
              r'''$.content''',
            ).toString(),
            style: FlutterFlowTheme.of(context).labelMedium.override(
                  fontFamily: 'Inter',
                  letterSpacing: 0.0,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 16.0, 24.0, 0.0),
          child: Builder(
            builder: (context) {
              final urls = functions
                  .listStringToListImage((getJsonField(
                    widget.data,
                    r'''$.urls''',
                    true,
                  ) as List)
                      .map<String>((s) => s.toString())
                      .toList())
                  .toList();

              return Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: List.generate(urls.length, (urlsIndex) {
                  final urlsItem = urls[urlsIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: FlutterFlowExpandedImageView(
                            image: Image.network(
                              urlsItem,
                              fit: BoxFit.contain,
                            ),
                            allowRotation: false,
                            tag: urlsItem,
                            useHeroAnimation: true,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: urlsItem,
                      transitionOnUserGestures: true,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          urlsItem,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
