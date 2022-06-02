import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/screens/ParasitologicalAnalysisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/widgets/ParasitologicalAnalysisListWidget.dart';

class ParasitologicalAnalysisListScreenWidget extends StatefulWidget {
  String analysisId;

  ParasitologicalAnalysisListScreenWidget({Key? key, required this.analysisId})
      : super(key: key);

  @override
  _ParasitologicalAnalysisListScreenWidgetState createState() {
    return _ParasitologicalAnalysisListScreenWidgetState();
  }
}

class _ParasitologicalAnalysisListScreenWidgetState
    extends State<ParasitologicalAnalysisListScreenWidget> {
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
      screen: ParasitologicalAnalysisFormScreenWidget(
          analysisIdToAdd: widget.analysisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.analysisId} Parazitolojik Analiz Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addParasitologicalAnalysisButton",
      ),
      body: ParasitologicalAnalysisListWidget(analysisId: widget.analysisId),
    );
  }
}
