import '/components/feed/feed_list_tile_component/feed_list_tile_component_widget.dart';
import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'feed_screen_model.dart';
export 'feed_screen_model.dart';

class FeedScreenWidget extends StatefulWidget {
  const FeedScreenWidget({super.key});

  @override
  State<FeedScreenWidget> createState() => _FeedScreenWidgetState();
}

class _FeedScreenWidgetState extends State<FeedScreenWidget> {
  late FeedScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.getWhoIFollowOutput = await actions.getWhoIFollow(
        context,
      );
      _model.getWhoFollowMeOutput = await actions.getWhoFollowMe(
        context,
      );

      safeSetState(() {});
    });

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
              'x33ci2my' /* Feeds */,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'xi65xko6' /* Who follow me */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    if (_model.getWhoFollowMeOutput != null &&
                        (_model.getWhoFollowMeOutput)!.isNotEmpty)
                      Builder(
                        builder: (context) {
                          final whoFollowMe =
                              _model.getWhoFollowMeOutput!.toList();

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(whoFollowMe.length,
                                    (whoFollowMeIndex) {
                              final whoFollowMeItem =
                                  whoFollowMe[whoFollowMeIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  wrapWithModel(
                                    model: _model.userAvatarComponentModels1
                                        .getModel(
                                      getJsonField(
                                        whoFollowMeItem,
                                        r'''$.uid''',
                                      ).toString(),
                                      whoFollowMeIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: UserAvatarComponentWidget(
                                      key: Key(
                                        'Keylkx_${getJsonField(
                                          whoFollowMeItem,
                                          r'''$.uid''',
                                        ).toString()}',
                                      ),
                                      uid: getJsonField(
                                        whoFollowMeItem,
                                        r'''$.uid''',
                                      ).toString(),
                                      size: 60.0,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model
                                        .userDisplayNameComponentModels1
                                        .getModel(
                                      getJsonField(
                                        whoFollowMeItem,
                                        r'''$.uid''',
                                      ).toString(),
                                      whoFollowMeIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: UserDisplayNameComponentWidget(
                                      key: Key(
                                        'Keyqjm_${getJsonField(
                                          whoFollowMeItem,
                                          r'''$.uid''',
                                        ).toString()}',
                                      ),
                                      uid: getJsonField(
                                        whoFollowMeItem,
                                        r'''$.uid''',
                                      ).toString(),
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              );
                            })
                                .divide(const SizedBox(width: 8.0))
                                .addToStart(const SizedBox(width: 24.0))
                                .addToEnd(const SizedBox(width: 24.0)),
                          );
                        },
                      ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          '8lxncbt9' /* Who I follow me */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                    if (_model.getWhoIFollowOutput != null &&
                        (_model.getWhoIFollowOutput)!.isNotEmpty)
                      Builder(
                        builder: (context) {
                          final whoIfollow =
                              _model.getWhoIFollowOutput!.toList();

                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(whoIfollow.length,
                                    (whoIfollowIndex) {
                              final whoIfollowItem =
                                  whoIfollow[whoIfollowIndex];
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  wrapWithModel(
                                    model: _model.userAvatarComponentModels2
                                        .getModel(
                                      whoIfollowItem,
                                      whoIfollowIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: UserAvatarComponentWidget(
                                      key: Key(
                                        'Keys8p_$whoIfollowItem',
                                      ),
                                      uid: whoIfollowItem,
                                      size: 60.0,
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model
                                        .userDisplayNameComponentModels2
                                        .getModel(
                                      whoIfollowItem,
                                      whoIfollowIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: UserDisplayNameComponentWidget(
                                      key: Key(
                                        'Keywof_$whoIfollowItem',
                                      ),
                                      uid: whoIfollowItem,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              );
                            })
                                .divide(const SizedBox(width: 8.0))
                                .addToStart(const SizedBox(width: 24.0))
                                .addToEnd(const SizedBox(width: 24.0)),
                          );
                        },
                      ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    direction: Axis.horizontal,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    clipBehavior: Clip.none,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          await actions.createData(
                            context,
                            'feed',
                            'feed title A ${random_data.randomName(true, true)}',
                            'feed content A ${random_data.randomName(true, true)}',
                            List.generate(
                                random_data.randomInteger(0, 0),
                                (index) => random_data.randomString(
                                      0,
                                      0,
                                      true,
                                      false,
                                      false,
                                    )).toList(),
                            <String, dynamic>{},
                            (key) async {
                              _model.readAOutput = await actions.readData(
                                context,
                                key,
                              );
                              _model.dataA = _model.readAOutput;
                              await actions.createFeed(
                                context,
                                _model.readAOutput!,
                              );
                            },
                            (error) async {},
                          );

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'r516jm08' /* Create A */,
                        ),
                        options: FFButtonOptions(
                          height: 34.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await actions.createData(
                            context,
                            'feed',
                            'feed title B ${random_data.randomName(true, true)}',
                            'feed content B ${random_data.randomName(true, true)}',
                            List.generate(
                                random_data.randomInteger(0, 0),
                                (index) => random_data.randomString(
                                      0,
                                      0,
                                      true,
                                      false,
                                      false,
                                    )).toList(),
                            <String, dynamic>{},
                            (key) async {
                              _model.readBOutput = await actions.readData(
                                context,
                                key,
                              );
                              _model.dataB = _model.readBOutput;
                              await actions.createFeed(
                                context,
                                _model.readBOutput!,
                              );
                            },
                            (error) async {},
                          );

                          safeSetState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          'z5mdg649' /* Create B */,
                        ),
                        options: FFButtonOptions(
                          height: 34.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.transparent,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            width: 1.6,
                          ),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      if (_model.dataA != null)
                        FFButtonWidget(
                          onPressed: () async {
                            await actions.updateData(
                              context,
                              getJsonField(
                                _model.dataA,
                                r'''$.key''',
                              ).toString(),
                              null,
                              'Title Feed A (UPDATED) ${random_data.randomName(true, false)}',
                              'Content Feed A (UPDATED~~~~~) ${random_data.randomName(true, true)}',
                              List.generate(
                                  random_data.randomInteger(0, 0),
                                  (index) => random_data.randomString(
                                        0,
                                        0,
                                        true,
                                        false,
                                        false,
                                      )).toList(),
                              <String, dynamic>{},
                              () async {
                                _model.updatedFeedAOutput =
                                    await actions.readData(
                                  context,
                                  getJsonField(
                                    _model.dataA,
                                    r'''$.key''',
                                  ).toString(),
                                );
                                await actions.updateFeed(
                                  context,
                                  _model.updatedFeedAOutput!,
                                );
                              },
                              (error) async {},
                            );

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'kughqm1v' /* Update A */,
                          ),
                          options: FFButtonOptions(
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      if (_model.dataB != null)
                        FFButtonWidget(
                          onPressed: () async {
                            await actions.updateData(
                              context,
                              getJsonField(
                                _model.dataB,
                                r'''$.key''',
                              ).toString(),
                              null,
                              'Title Feed B (Change) ${random_data.randomName(true, false)}',
                              'Content Feed A (Change======) ${random_data.randomName(true, true)}',
                              List.generate(
                                  random_data.randomInteger(0, 0),
                                  (index) => random_data.randomString(
                                        0,
                                        0,
                                        true,
                                        false,
                                        false,
                                      )).toList(),
                              <String, dynamic>{},
                              () async {
                                _model.updatedFeedBOutput =
                                    await actions.readData(
                                  context,
                                  getJsonField(
                                    _model.dataB,
                                    r'''$.key''',
                                  ).toString(),
                                );
                                await actions.updateFeed(
                                  context,
                                  _model.updatedFeedBOutput!,
                                );
                              },
                              (error) async {},
                            );

                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            '8uz5b8hz' /* Update B */,
                          ),
                          options: FFButtonOptions(
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      if (_model.dataA != null)
                        FFButtonWidget(
                          onPressed: () async {
                            await actions.deleteFeed(
                              context,
                              getJsonField(
                                _model.dataA,
                                r'''$.key''',
                              ).toString(),
                            );
                            _model.dataA = null;
                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            'a0ppp4g4' /* Delete A */,
                          ),
                          options: FFButtonOptions(
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      if (_model.dataB != null)
                        FFButtonWidget(
                          onPressed: () async {
                            await actions.deleteFeed(
                              context,
                              getJsonField(
                                _model.dataB,
                                r'''$.key''',
                              ).toString(),
                            );
                            _model.dataB = null;
                            safeSetState(() {});
                          },
                          text: FFLocalizations.of(context).getText(
                            '8tzuiw92' /* Delete B */,
                          ),
                          options: FFButtonOptions(
                            height: 34.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              width: 1.6,
                            ),
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '6qfk4pab' /* Feeds */,
                    ),
                    style: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Inter Tight',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: custom_widgets.FeedListView(
                  width: double.infinity,
                  height: double.infinity,
                  shrinkWrap: true,
                  builder: (dynamic data) => FeedListTileComponentWidget(
                    data: data,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
