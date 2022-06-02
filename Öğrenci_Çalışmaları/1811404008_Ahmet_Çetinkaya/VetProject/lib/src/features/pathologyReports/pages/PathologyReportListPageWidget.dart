import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/pages/PathologyReportFormPageWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/widgets/PathologyReportList.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/widgets/MainDrawer.dart';

class PathologyReportListPageWidget extends StatefulWidget {
  static const routeName = 'pathologyReports';

  const PathologyReportListPageWidget({Key? key}) : super(key: key);

  @override
  _PathologyReportListPageWidgetState createState() {
    return _PathologyReportListPageWidgetState();
  }
}

class _PathologyReportListPageWidgetState
    extends State<PathologyReportListPageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _navigate(String path) {
    Navigator.pushNamed(context, path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patoloji Raporları'),
      ),
      drawer: const Drawer(
        child: MainDrawer(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _navigate(PathologyReportFormPageWidget.routeName),
        heroTag: "addPathologyReportButton",
      ),
      body: PathologyReportList(),
    );
  }
}
