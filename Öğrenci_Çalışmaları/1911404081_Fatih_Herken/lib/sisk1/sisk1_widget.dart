import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../sistem/sistem_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sisk1Widget extends StatefulWidget {
  const Sisk1Widget({Key key}) : super(key: key);

  @override
  _Sisk1WidgetState createState() => _Sisk1WidgetState();
}

class _Sisk1WidgetState extends State<Sisk1Widget> {
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
                builder: (context) => SistemWidget(),
              ),
            );
          },
        ),
        title: Text(
          'Sistem Kuponları',
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
          child: Align(
            alignment: AlignmentDirectional(-0.05, 0),
            child: Image.network(
              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/sd3w64vjftem/c7bada6b-afba-45dd-8d3e-973fa04bdebb.jpg',
              width: 1000,
              height: 1000,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
