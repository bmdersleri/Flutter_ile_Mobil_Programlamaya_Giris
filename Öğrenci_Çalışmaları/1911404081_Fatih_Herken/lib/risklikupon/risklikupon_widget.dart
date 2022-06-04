import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../iddafatihi/iddafatihi_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RisklikuponWidget extends StatefulWidget {
  const RisklikuponWidget({Key key}) : super(key: key);

  @override
  _RisklikuponWidgetState createState() => _RisklikuponWidgetState();
}

class _RisklikuponWidgetState extends State<RisklikuponWidget> {
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
          'RİSKLİ KUPON',
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
          child: Image.network(
            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/d4zanagc9d2l/b9982d75-d62d-4f1d-933a-e60694d2e130.jpg',
            width: 700,
            height: 700,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
