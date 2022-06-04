import '../bankokuponlar/bankokuponlar_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../iddafatihi/iddafatihi_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class Bankok2Widget extends StatefulWidget {
  const Bankok2Widget({Key key}) : super(key: key);

  @override
  _Bankok2WidgetState createState() => _Bankok2WidgetState();
}

class _Bankok2WidgetState extends State<Bankok2Widget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // On page load action.
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IddafatihiWidget(),
        ),
      );
    });
  }

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
                builder: (context) => BankokuponlarWidget(),
              ),
            );
          },
        ),
        title: Text(
          'BANKO KUPON',
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
                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/idda-fatihi-eqtjlb/assets/02dyck6ur308/2e3b60a4-05b3-4157-8ee1-b9446e022447.jpg',
                width: 700,
                height: 700,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
