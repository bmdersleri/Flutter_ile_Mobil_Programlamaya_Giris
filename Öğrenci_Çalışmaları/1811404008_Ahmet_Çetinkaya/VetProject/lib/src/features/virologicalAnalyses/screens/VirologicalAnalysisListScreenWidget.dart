import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/screens/VirologicalAnalysisFormScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/widgets/VirologicalAnalysisListWidget.dart';

class VirologicalAnalysisListScreenWidget extends StatefulWidget {
  String analysisId;

  VirologicalAnalysisListScreenWidget({Key? key, required this.analysisId})
      : super(key: key);

  @override
  _VirologicalAnalysisListScreenWidgetState createState() {
    return _VirologicalAnalysisListScreenWidgetState();
  }
}

class _VirologicalAnalysisListScreenWidgetState
    extends State<VirologicalAnalysisListScreenWidget> {
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
      screen: VirologicalAnalysisFormScreenWidget(
          analysisIdToAdd: widget.analysisId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.analysisId} Virolojik Analiz Kayıtları'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _navigateToAddForm,
        heroTag: "addVirologicalAnalysisButton",
      ),
      body: VirologicalAnalysisListWidget(analysisId: widget.analysisId),
    );
  }
}
