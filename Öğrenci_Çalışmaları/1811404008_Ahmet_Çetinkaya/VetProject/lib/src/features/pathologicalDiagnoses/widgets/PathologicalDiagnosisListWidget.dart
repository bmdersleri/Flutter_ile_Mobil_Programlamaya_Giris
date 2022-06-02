import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/models/PathologicalDiagnosesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/models/PathologicalDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/services/PathologicalDiagnosesService.dart';

class PathologicalDiagnosisListWidget extends StatefulWidget {
  final PathologicalDiagnosesService _pathologicalDiagnosesService =
      PathologicalDiagnosesService();
  String? diagnosisId;

  PathologicalDiagnosisListWidget({Key? key, this.diagnosisId})
      : super(key: key);

  @override
  _PathologicalDiagnosisListWidgetState createState() {
    return _PathologicalDiagnosisListWidgetState();
  }
}

class _PathologicalDiagnosisListWidgetState
    extends State<PathologicalDiagnosisListWidget> {
  bool _isLoading = true;
  PathologicalDiagnosisListModel? _pathologicalDiagnosisList;

  @override
  void initState() {
    super.initState();
    _getList(byDiagnosisId: widget.diagnosisId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getList(
      {int page = 0, int pageSize = 10, String? byDiagnosisId}) async {
    setState(() {
      _isLoading = true;
    });

    var result = await widget._pathologicalDiagnosesService
        .getList(page: page, pageSize: pageSize, byDiagnosisId: byDiagnosisId);

    setState(() {
      _pathologicalDiagnosisList =
          PathologicalDiagnosisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_pathologicalDiagnosisList?.currentPage == 1) return;
    _getList(
        page: (_pathologicalDiagnosisList?.currentPage)! - 1,
        byDiagnosisId: widget.diagnosisId);
  }

  void _nextPage() {
    if (_pathologicalDiagnosisList?.currentPage ==
        _pathologicalDiagnosisList?.lastPage) return;
    _getList(
        page: (_pathologicalDiagnosisList?.currentPage)! + 1,
        byDiagnosisId: widget.diagnosisId);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => _getList(
                page: _pathologicalDiagnosisList?.currentPage as int,
                pageSize: _pathologicalDiagnosisList?.perPage as int,
                byDiagnosisId: widget.diagnosisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_pathologicalDiagnosisList?.data.isEmpty == true)
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Kayıt Yok."),
                  ))
                else
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: DataTable(
                            columns: const [
                              DataColumn(label: Text("Durum")),
                              DataColumn(label: Text("Bulgu Türü")),
                              DataColumn(label: Text("Atanan")),
                              DataColumn(label: Text("Onaylan")),
                              DataColumn(label: Text("Oluşturulma")),
                              DataColumn(label: Text("Güncellenme"))
                            ],
                            rows: PathologicalDiagnosesListDataTableRow(
                                context, _pathologicalDiagnosisList?.data,
                                onBack: () => _getList(
                                    page: _pathologicalDiagnosisList
                                        ?.currentPage as int,
                                    pageSize: _pathologicalDiagnosisList
                                        ?.perPage as int,
                                    byDiagnosisId: widget.diagnosisId)).rows),
                        scrollDirection: Axis.horizontal,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left_rounded),
                            onPressed: _prevPage,
                          ),
                          Text(
                              'Sayfa: ${_pathologicalDiagnosisList?.currentPage}'),
                          IconButton(
                              icon: const Icon(Icons.chevron_right_rounded),
                              onPressed: _nextPage)
                        ],
                      )
                    ],
                  )
              ],
            ),
          );
  }
}
