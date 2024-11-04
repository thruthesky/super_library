import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'chat_room_list_screen_model.dart';
export 'chat_room_list_screen_model.dart';

class ChatRoomListScreenWidget extends StatefulWidget {
  const ChatRoomListScreenWidget({super.key});

  @override
  State<ChatRoomListScreenWidget> createState() =>
      _ChatRoomListScreenWidgetState();
}

class _ChatRoomListScreenWidgetState extends State<ChatRoomListScreenWidget> {
  late ChatRoomListScreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatRoomListScreenModel());

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
          automaticallyImplyLeading: false,
          title: Text(
            'Chat',
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
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: custom_widgets.ChatRoomListView(
              width: double.infinity,
              height: double.infinity,
              onTap: (roomId) async {
                context.pushNamed(
                  'ChatRoomScreen',
                  queryParameters: {
                    'uidOrRoomId': serializeParam(
                      roomId,
                      ParamType.String,
                    ),
                  }.withoutNulls,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
