import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/screens/PathologicalDiagnosisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/widgets/PathologicalDiagnosisListWidget.dart';

class PathologicalDiagnosisListScreenWidget extends StatefulWidget {
  String diagnosisId;

  PathologicalDiagnosisListScreenWidget({Key? key, required this.diagnosisId})
      : super(key: key);

  @override
  _PathologicalDiagnosisListScreenWidgetState createState() {
    return _PathologicalDiagnosisListScreenWidgetState();
  }
}

class _PathologicalDiagnosisListScreenWidgetState
    extends State<PathologicalDiagnosisListScreenWidget> {
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
      screen: PathologicalDiagnosisFormScreenWidget(
          diagnosisIdToAdd: widget.diagnosisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.diagnosisId} Patolojik Bulgu Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addPathologicalDiagnosisButton",
      ),
      body: PathologicalDiagnosisListWidget(diagnosisId: widget.diagnosisId),
    );
  }
}
