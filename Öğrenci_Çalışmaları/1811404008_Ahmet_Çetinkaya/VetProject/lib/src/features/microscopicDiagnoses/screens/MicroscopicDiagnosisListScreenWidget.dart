import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/screens/MicroscopicDiagnosisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/widgets/MicroscopicDiagnosisListWidget.dart';

class MicroscopicDiagnosisListScreenWidget extends StatefulWidget {
  String diagnosisId;

  MicroscopicDiagnosisListScreenWidget({Key? key, required this.diagnosisId})
      : super(key: key);

  @override
  _MicroscopicDiagnosisListScreenWidgetState createState() {
    return _MicroscopicDiagnosisListScreenWidgetState();
  }
}

class _MicroscopicDiagnosisListScreenWidgetState
    extends State<MicroscopicDiagnosisListScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _navigateToAddForm() {
    pushNewScreen(
      context,
      screen: MicroscopicDiagnosisFormScreenWidget(
          diagnosisIdToAdd: widget.diagnosisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.diagnosisId} Mikroskobik Bulgu Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addMicroscopicDiagnosisButton",
      ),
      body: MicroscopicDiagnosisListWidget(diagnosisId: widget.diagnosisId),
    );
  }
}
