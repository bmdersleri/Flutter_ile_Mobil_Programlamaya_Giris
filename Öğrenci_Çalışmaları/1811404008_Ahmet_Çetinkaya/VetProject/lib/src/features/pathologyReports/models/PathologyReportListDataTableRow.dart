import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReport.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/pages/PathologyReportScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';

class PathologyReportListDataTableRow {
  late List<DataRow> rows;
  late BuildContext _context;
  late Function? _onBack;

  PathologyReportListDataTableRow(
      BuildContext context, List<PathologyReport>? pathologyList,
      {Function? onBack}) {
    _context = context;
    _onBack = onBack;

    if (pathologyList == null) {
      rows = [];
      return;
    }

    rows = pathologyList
        .map((p) => DataRow(
              cells: [
                DataCell(Text(p.protocolNumber as String),
                    showEditIcon: true,
                    onTap: () =>
                        _navigatePathologyReportForm(p.protocolNumber)),
                DataCell(Text(_generateSpecimensText(p.specimens))),
                DataCell(Text(_getOwnerNameFromSpecimens(p.specimens))),
                DataCell(Text(p.createdAt != null
                    ? p.createdAt.toString().substring(0, 16)
                    : ""))
              ],
            ))
        .toList();
  }

  _navigatePathologyReportForm(String? protocolNumber) {
    if (protocolNumber == null) return;
    Navigator.pushNamed(_context, PathologyReportScreenWidget.routeName,
            arguments: {'protocolNumber': protocolNumber})
        .then((value) => {if (_onBack != null) _onBack!()});
  }

  String _generateSpecimensText(List<Specimen>? specimens) {
    if (specimens == null) return "Yok";

    Map<String, int> specimensCount = {};
    for (var s in specimens) {
      if (specimensCount[s.genus?.name] != null) {
        specimensCount[s.genus?.name ?? ""] =
            specimensCount[s.genus?.name]! + 1;
      } else {
        specimensCount[s.genus?.name ?? ""] = 1;
      }
    }
    String specimensFieldText = "";
    specimensCount.forEach((name, count) {
      specimensFieldText += "${count}x $name, ";
    });
    return specimensFieldText;
  }

  String _getOwnerNameFromSpecimens(List<Specimen>? specimen) {
    if (specimen == null) return 'Yok';
    if (specimen.isEmpty) return 'Yok';

    return specimen.first.specimenOwner?.name ?? 'Yok';
  }
}
