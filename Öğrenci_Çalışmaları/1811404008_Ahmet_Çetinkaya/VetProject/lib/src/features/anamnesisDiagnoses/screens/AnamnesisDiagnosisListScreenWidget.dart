import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/screens/AnamnesisDiagnosisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/widgets/AnamnesisDiagnosisListWidget.dart';

class AnamnesisDiagnosisListScreenWidget extends StatefulWidget {
  String diagnosisId;

  AnamnesisDiagnosisListScreenWidget({Key? key, required this.diagnosisId})
      : super(key: key);

  @override
  _AnamnesisDiagnosisListScreenWidgetState createState() {
    return _AnamnesisDiagnosisListScreenWidgetState();
  }
}

class _AnamnesisDiagnosisListScreenWidgetState
    extends State<AnamnesisDiagnosisListScreenWidget> {
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
      screen: AnamnesisDiagnosisFormScreenWidget(
          diagnosisIdToAdd: widget.diagnosisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.diagnosisId} Anamnez Bulgu Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addAnamnesisDiagnosisButton",
      ),
      body: AnamnesisDiagnosisListWidget(diagnosisId: widget.diagnosisId),
    );
  }
}
