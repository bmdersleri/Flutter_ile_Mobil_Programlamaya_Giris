import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Sex.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/screens/SpecimenFormScreenWidget.dart';

class SpecimensListDataTableRow {
  late List<DataRow> rows;
  late BuildContext _context;
  late Function? _onBack;

  _navigateSpecimensForm(int id) {
    pushNewScreen(_context,
            screen: SpecimenFormScreenWidget(specimenIdToUpdate: id))
        .then((value) => {if (_onBack != null) _onBack!()});
  }

  SpecimensListDataTableRow(BuildContext context, List<Specimen>? specimensList,
      {Function? onBack}) {
    _context = context;
    _onBack = onBack;

    if (specimensList == null) {
      rows = [];
      return;
    }

    rows = specimensList
        .map((s) => DataRow(
              cells: [
                DataCell(Text(s.genus != null ? s.genus?.name as String : ""),
                    showEditIcon: true,
                    onTap: () => _navigateSpecimensForm(s.id as int)),
                DataCell(Text(s.age.toString())),
                DataCell(Text(Sex.fromId(s.sex as int).name ?? "Bilinmiyor")),
                DataCell(Text(s.specimenOwner != null
                    ? s.specimenOwner?.name as String
                    : ""))
              ],
            ))
        .toList();
  }
}
