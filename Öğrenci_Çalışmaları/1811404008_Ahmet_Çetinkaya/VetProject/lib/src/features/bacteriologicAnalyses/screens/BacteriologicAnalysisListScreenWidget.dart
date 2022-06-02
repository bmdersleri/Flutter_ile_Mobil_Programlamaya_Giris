import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/screens/BacteriologicAnalysisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/widgets/BacteriologicAnalysisListWidget.dart';

class BacteriologicAnalysisListScreenWidget extends StatefulWidget {
  String analysisId;

  BacteriologicAnalysisListScreenWidget({Key? key, required this.analysisId})
      : super(key: key);

  @override
  _BacteriologicAnalysisListScreenWidgetState createState() {
    return _BacteriologicAnalysisListScreenWidgetState();
  }
}

class _BacteriologicAnalysisListScreenWidgetState
    extends State<BacteriologicAnalysisListScreenWidget> {
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
      screen: BacteriologicAnalysisFormScreenWidget(
          analysisIdToAdd: widget.analysisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.analysisId} Bakteriyolojik Analiz Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addBacteriologicAnalysisButton",
      ),
      body: BacteriologicAnalysisListWidget(analysisId: widget.analysisId),
    );
  }
}
