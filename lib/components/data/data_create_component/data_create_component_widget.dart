import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'data_create_component_model.dart';
export 'data_create_component_model.dart';

class DataCreateComponentWidget extends StatefulWidget {
  const DataCreateComponentWidget({
    super.key,
    required this.category,
  });

  final String? category;

  @override
  State<DataCreateComponentWidget> createState() =>
      _DataCreateComponentWidgetState();
}

class _DataCreateComponentWidgetState extends State<DataCreateComponentWidget> {
  late DataCreateComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DataCreateComponentModel());

    _model.titleTextController ??= TextEditingController();
    _model.titleFocusNode ??= FocusNode();

    _model.contentTextController ??= TextEditingController();
    _model.contentFocusNode ??= FocusNode();

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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
              child: SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: _model.titleTextController,
                  focusNode: _model.titleFocusNode,
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: FFLocalizations.of(context).getText(
                      'zg37ehn8' /* TITLE */,
                    ),
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                    hintText: FFLocalizations.of(context).getText(
                      '2bbsspiu' /* Input title */,
                    ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator:
                      _model.titleTextControllerValidator.asValidator(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
              child: SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: _model.contentTextController,
                  focusNode: _model.contentFocusNode,
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: FFLocalizations.of(context).getText(
                      '7lfic231' /* CONTENT */,
                    ),
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                    hintText: FFLocalizations.of(context).getText(
                      '7a2c64aa' /* Input Content */,
                    ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Inter',
                              letterSpacing: 0.0,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primaryText,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 1.6,
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Inter',
                        letterSpacing: 0.0,
                      ),
                  maxLines: 7,
                  minLines: 4,
                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                  validator: _model.contentTextControllerValidator
                      .asValidator(context),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                await actions.createData(
                  context,
                  widget.category!,
                  _model.titleTextController.text,
                  _model.contentTextController.text,
                  _model.urls.toList(),
                  <String, dynamic>{},
                  (key) async {
                    context.safePop();
                  },
                  (error) async {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error,
                          style: TextStyle(
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        duration: const Duration(milliseconds: 4000),
                        backgroundColor: FlutterFlowTheme.of(context).error,
                      ),
                    );
                  },
                );
              },
              text: FFLocalizations.of(context).getText(
                '4drp86mr' /* CREATE */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: Colors.transparent,
                textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
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
    );
  }
}
