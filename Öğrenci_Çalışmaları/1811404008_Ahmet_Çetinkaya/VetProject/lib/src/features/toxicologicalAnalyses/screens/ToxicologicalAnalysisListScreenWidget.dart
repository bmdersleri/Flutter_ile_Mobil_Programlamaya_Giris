import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/screens/ToxicologicalAnalysisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/widgets/ToxicologicalAnalysisListWidget.dart';

class ToxicologicalAnalysisListScreenWidget extends StatefulWidget {
  String analysisId;

  ToxicologicalAnalysisListScreenWidget({Key? key, required this.analysisId})
      : super(key: key);

  @override
  _ToxicologicalAnalysisListScreenWidgetState createState() {
    return _ToxicologicalAnalysisListScreenWidgetState();
  }
}

class _ToxicologicalAnalysisListScreenWidgetState
    extends State<ToxicologicalAnalysisListScreenWidget> {
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
      screen: ToxicologicalAnalysisFormScreenWidget(
          analysisIdToAdd: widget.analysisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.analysisId} Toksikolojik Analiz Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addToxicologicalAnalysisButton",
      ),
      body: ToxicologicalAnalysisListWidget(analysisId: widget.analysisId),
    );
  }
}
