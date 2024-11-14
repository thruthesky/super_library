import '/components/user/user_avatar_component/user_avatar_component_widget.dart';
import '/components/user/user_display_name_component/user_display_name_component_widget.dart';
import '/components/user/user_list_tile_component/user_list_tile_component_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'home_screen_model.dart';
export 'home_screen_model.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  late HomeScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeScreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loginUserUidActionOutput = await actions.getLoginUserUid();
      _model.loginUserUidState = _model.loginUserUidActionOutput;
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              'playet81' /* Super Library Home */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Container(
              decoration: const BoxDecoration(),
              child: const Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: custom_widgets.UserAvatar(
                    width: 48.0,
                    height: 48.0,
                    uid: '-',
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'aed2aepi' /* Super Library supports the max... */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Inter',
                                  letterSpacing: 0.0,
                                ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await launchURL(
                                'https://thruthesky.github.io/super_library/');
                          },
                          text: FFLocalizations.of(context).getText(
                            'vtcq6g9l' /* Read detail document */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
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
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed('FeedScreen');
                          },
                          text: FFLocalizations.of(context).getText(
                            'yw86bglk' /* Feed list view */,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
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
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                        child: Text(
                          'UID: ${_model.loginUserUidState}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      Text(
                        'Debug: ${valueOrDefault<String>(
                          FFLibraryValues().debugLog?.toString(),
                          '[false]',
                        )}',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_model.loginUserUidState != null &&
                              _model.loginUserUidState != '')
                            wrapWithModel(
                              model: _model.userAvatarComponentModel1,
                              updateCallback: () => safeSetState(() {}),
                              child: UserAvatarComponentWidget(
                                uid: _model.loginUserUidState!,
                                size: 40.0,
                                radius: 33.0,
                              ),
                            ),
                          if (_model.loginUserUidState != null &&
                              _model.loginUserUidState != '')
                            Expanded(
                              child: wrapWithModel(
                                model: _model.userDisplayNameComponentModel,
                                updateCallback: () => safeSetState(() {}),
                                child: UserDisplayNameComponentWidget(
                                  uid: _model.loginUserUidState!,
                                  fontSize: 18.0,
                                  fontColor:
                                      FlutterFlowTheme.of(context).tertiary,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: custom_widgets.UserAvatar(
                              width: 40.0,
                              height: 40.0,
                              uid: 'abcdefgh',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.userAvatarComponentModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: const UserAvatarComponentWidget(
                              uid: 'abcdefh',
                              size: 40.0,
                              radius: 30.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: custom_widgets.UserListView(
                    width: double.infinity,
                    height: double.infinity,
                    horizontalScroll: false,
                    reverse: true,
                    builder: (dynamic data) => UserListTileComponentWidget(
                      data: data,
                      onTap: (uid) async {
                        context.pushNamed(
                          'PublicProfileScreen',
                          queryParameters: {
                            'uid': serializeParam(
                              getJsonField(
                                FFAppState()
                                    .userListTileComponentActionParameter,
                                r'''$.uid''',
                              ).toString(),
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      },
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
