import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/screens/MacroscopicDiagnosisFormScreenWidget.dart';

class MacroscopicDiagnosesListDataTableRow {
  late List<DataRow> rows;
  late BuildContext _context;
  late Function? _onBack;

  _navigateForm(int id) {
    pushNewScreen(_context,
            screen: MacroscopicDiagnosisFormScreenWidget(id: id))
        .then((value) => {if (_onBack != null) _onBack!()});
  }

  MacroscopicDiagnosesListDataTableRow(BuildContext context,
      List<MacroscopicDiagnosis>? macroscopicDiagnosisList,
      {Function? onBack}) {
    _context = context;
    _onBack = onBack;

    if (macroscopicDiagnosisList == null) {
      rows = [];
      return;
    }

    rows = macroscopicDiagnosisList
        .map((s) => DataRow(
              cells: [
                DataCell(Text(s.status != null ? s.status?.name as String : ""),
                    showEditIcon: true,
                    onTap: () => _navigateForm(s.id as int)),
                DataCell(Text(s.assigneeUser != null
                    ? "${s.assigneeUser?.firstName} ${s.assigneeUser?.lastName}"
                    : "Yok")),
                DataCell(Text(s.approvedByUser != null
                    ? "${s.approvedByUser?.firstName} ${s.approvedByUser?.lastName}"
                    : "Yok")),
                DataCell(Text(s.createdAt.toString().substring(0, 16))),
                DataCell(Text(s.updatedAt != null
                    ? s.updatedAt.toString().substring(0, 16)
                    : "")),
              ],
            ))
        .toList();
  }
}
