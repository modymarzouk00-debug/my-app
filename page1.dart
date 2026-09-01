import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'page1model.dart';
export 'page1model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().userdate) {
        context.pushNamed(MainpageWidget.routeName);
      }
    });

    animationsMap.addAll({
      'stackOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOutQuint,
            delay: 0.0.ms,
            duration: 1250.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    // On page dispose action.
    () async {
      FFAppState().isFirstTime = false;
      safeSetState(() {});
    }();

    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).alternate,
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            FFAppState().userdate = true;
            safeSetState(() {});
          },
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Blue_Wallpaper.jpeg',
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.05, -0.3),
                child: Text(
                  'مرحبا بك',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 50,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w900,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.06, 0.19),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(
                      MainpageWidget.routeName,
                      queryParameters: {
                        'isSkipped': serializeParam(
                          true,
                          ParamType.bool,
                        ),
                      }.withoutNulls,
                    );
                  },
                  text: 'تخطي',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 60,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0x3039D2C0),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w900,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w900,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.06, -0.03),
                child: FFButtonWidget(
                  onPressed: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    final user = await authManager.signInWithGoogle(context);
                    if (user == null) {
                      return;
                    }

                    context.goNamedAuth(
                        SpendingWidget.routeName, context.mounted);
                  },
                  text: 'تسجيل دخول',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 60,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: Color(0x3039D2C0),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w900,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 20,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w900,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    elevation: 0,
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ],
          ),
        ).animateOnPageLoad(animationsMap['stackOnPageLoadAnimation']!),
      ),
    );
  }
}

