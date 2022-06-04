import '../bankokuponlar/bankokuponlar_widget.dart';
import '../bizeulas/bizeulas_widget.dart';
import '../cank/cank_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../risklikupon/risklikupon_widget.dart';
import '../sistem/sistem_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class IddafatihiWidget extends StatefulWidget {
  const IddafatihiWidget({Key key}) : super(key: key);

  @override
  _IddafatihiWidgetState createState() => _IddafatihiWidgetState();
}

class _IddafatihiWidgetState extends State<IddafatihiWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      duration: 600,
      fadeIn: true,
      initialState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startPageLoadAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onPageLoad),
      this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFBA5D5D),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/zd1d00old56n/anaekran.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.6, 0.8),
                child: Text(
                  'Sistem Kupon',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        fontSize: 16,
                        lineHeight: 3,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.6, 0.67),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SistemWidget(),
                      ),
                    );
                  },
                  text: '',
                  options: FFButtonOptions(
                    width: 100,
                    height: 100,
                    color: Color(0xFC3E6C37),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-0.6, 0.2),
                      child: InkWell(
                        onDoubleTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CankWidget(),
                            ),
                          );
                        },
                        child: FFButtonWidget(
                          onPressed: () {
                            print('CANLI pressed ...');
                          },
                          text: '',
                          options: FFButtonOptions(
                            width: 100,
                            height: 100,
                            color: Color(0xFC3E6C37),
                            textStyle: FlutterFlowTheme.of(context).bodyText2,
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: 15,
                          ),
                        ),
                      ).animated([animationsMap['buttonOnPageLoadAnimation']]),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.58, 0.2),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CankWidget(),
                            ),
                          );
                        },
                        child: Image.network(
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/xeiqm8fydmsv/canlı%20bahis.png',
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.58, 0.4),
                      child: AutoSizeText(
                        'Canlı Bahis',
                        textAlign: TextAlign.center,
                        maxLines: 25,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'Roboto',
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                              fontSize: 16,
                              lineHeight: 3,
                            ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(1.01, -0.81),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BizeulasWidget(),
                            ),
                          );
                        },
                        text: 'Bize ulaşın',
                        icon: FaIcon(
                          FontAwesomeIcons.solidCommentDots,
                        ),
                        options: FFButtonOptions(
                          width: 125,
                          height: 50,
                          color: Color(0x475CEF39),
                          textStyle: TextStyle(),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.58, 0.65),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SistemWidget(),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/v1pyh1e9s94n/Sistemm.png',
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.6, 0.8),
                child: Text(
                  'Riskli Kupon',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        fontSize: 16,
                        lineHeight: 3,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.6, 0.2),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BankokuponlarWidget(),
                      ),
                    );
                  },
                  text: '',
                  options: FFButtonOptions(
                    width: 100,
                    height: 100,
                    color: Color(0xFC3E6C37),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.57, 0.2),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BankokuponlarWidget(),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/lw12yw4ze3qf/Bankokupon.png',
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.6, 0.67),
                child: FFButtonWidget(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RisklikuponWidget(),
                      ),
                    );
                  },
                  text: '',
                  options: FFButtonOptions(
                    width: 100,
                    height: 100,
                    color: Color(0xFC3E6C37),
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.58, 0.65),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RisklikuponWidget(),
                      ),
                    );
                  },
                  child: Image.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/rfqbt9sloe64/Riskli%20kupon.png',
                    width: 85,
                    height: 85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.64, 0.4),
                child: Text(
                  'Banko Kupon',
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.of(context).primaryBtnText,
                        fontSize: 16,
                        lineHeight: 3,
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
