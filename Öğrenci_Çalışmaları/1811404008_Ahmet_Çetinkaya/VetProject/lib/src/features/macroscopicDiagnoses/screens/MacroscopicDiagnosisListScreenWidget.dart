import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/screens/MacroscopicDiagnosisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/widgets/MacroscopicDiagnosisListWidget.dart';

class MacroscopicDiagnosisListScreenWidget extends StatefulWidget {
  String diagnosisId;

  MacroscopicDiagnosisListScreenWidget({Key? key, required this.diagnosisId})
      : super(key: key);

  @override
  _MacroscopicDiagnosisListScreenWidgetState createState() {
    return _MacroscopicDiagnosisListScreenWidgetState();
  }
}

class _MacroscopicDiagnosisListScreenWidgetState
    extends State<MacroscopicDiagnosisListScreenWidget> {
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
      screen: MacroscopicDiagnosisFormScreenWidget(
          diagnosisIdToAdd: widget.diagnosisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.diagnosisId} Makroskobik Bulgu Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addMacroscopicDiagnosisButton",
      ),
      body: MacroscopicDiagnosisListWidget(diagnosisId: widget.diagnosisId),
    );
  }
}
