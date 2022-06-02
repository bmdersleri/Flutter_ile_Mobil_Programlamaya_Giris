import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReport.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';

class PathologyReportListDataTableSource extends DataTableSource {
  late final List<Map<String, dynamic>> _data;
  late final int count;

  PathologyReportListDataTableSource(
      List<PathologyReport>? pathologyList, this.count) {
    if (pathologyList == null) {
      _data = [];
      count = 0;
      return;
    }

    _data = pathologyList
        .map((p) => {
              'No': p.protocolNumber,
              'Numune': _generateSpecimensText(p.specimens),
              'Sahibi': _getOwnerNameFromSpecimens(p.specimens),
              'Kabul Tarihi': p.createdAt.toString(),
            })
        .cast<Map<String, dynamic>>()
        .toList();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['No'])),
      DataCell(Text(_data[index]['Numune'])),
      DataCell(Text(_data[index]['Sahibi'])),
      DataCell(Text(_data[index]['Kabul Tarihi'])),
    ]);
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
