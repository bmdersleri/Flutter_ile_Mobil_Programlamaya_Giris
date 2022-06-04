import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../sistem/sistem_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sisk3Widget extends StatefulWidget {
  const Sisk3Widget({Key key}) : super(key: key);

  @override
  _Sisk3WidgetState createState() => _Sisk3WidgetState();
}

class _Sisk3WidgetState extends State<Sisk3Widget> {
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.network(
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/9a28eua8rh0y/9928715f-26db-4b3f-af2e-4d19fa0f53d1.jpg',
                width: 500,
                height: 500,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
