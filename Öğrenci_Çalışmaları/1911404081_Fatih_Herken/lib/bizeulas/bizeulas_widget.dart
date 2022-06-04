import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../iddafatihi/iddafatihi_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BizeulasWidget extends StatefulWidget {
  const BizeulasWidget({Key key}) : super(key: key);

  @override
  _BizeulasWidgetState createState() => _BizeulasWidgetState();
}

class _BizeulasWidgetState extends State<BizeulasWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IddafatihiWidget(),
              ),
            );
          },
        ),
        title: Text(
          'BİZE ULAŞIN',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/iddafatihi-cxlcci/assets/qs63x99eus6c/sasad.jpg',
                width: 1000,
                fit: BoxFit.scaleDown,
              ),
              Align(
                alignment: AlignmentDirectional(0, 0.11),
                child: Text(
                  'Şunu hiçbir zaman unutmayalım idda da kesin kazanç yoktur. Bunun bilince oynamak lazım ve hiçbir şekilde aç gözlü olmadan oynamak gerekir. AKıllıca ve mantıklı şekilde kasa yönetimi sizi her zaman kar a sokacaktır. Haydi kazanalım. Bol şanslar :)',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-0.85, -0.3),
                child: Text(
                  'MAİL: fatih.herken5271@gmail.com\nFACEBOOK: Fatihherken20\nTELEFON: 05469390848',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-4.8, 0.52),
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/253/600',
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.37, -0.55),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF090F13),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color(0x3314181B),
                              offset: Offset(0, 2),
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF090F13),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color(0x3314181B),
                              offset: Offset(0, 2),
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: FaIcon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF090F13),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Color(0x3314181B),
                              offset: Offset(0, 2),
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Icon(
                          Icons.phone_sharp,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
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
