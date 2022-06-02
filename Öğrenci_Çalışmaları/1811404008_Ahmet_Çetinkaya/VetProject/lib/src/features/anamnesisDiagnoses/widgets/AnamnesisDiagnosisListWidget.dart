import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/models/AnamnesisDiagnosesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/models/AnamnesisDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/services/AnamnesisDiagnosesService.dart';

class AnamnesisDiagnosisListWidget extends StatefulWidget {
  final AnamnesisDiagnosesService _anamnesisDiagnosesService =
      AnamnesisDiagnosesService();
  String? diagnosisId;

  AnamnesisDiagnosisListWidget({Key? key, this.diagnosisId}) : super(key: key);

  @override
  _AnamnesisDiagnosisListWidgetState createState() {
    return _AnamnesisDiagnosisListWidgetState();
  }
}

class _AnamnesisDiagnosisListWidgetState
    extends State<AnamnesisDiagnosisListWidget> {
  bool _isLoading = true;
  AnamnesisDiagnosisListModel? _anamnesisDiagnosisList;

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

    var result = await widget._anamnesisDiagnosesService
        .getList(page: page, pageSize: pageSize, byDiagnosisId: byDiagnosisId);

    setState(() {
      _anamnesisDiagnosisList =
          AnamnesisDiagnosisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_anamnesisDiagnosisList?.currentPage == 1) return;
    _getList(
        page: (_anamnesisDiagnosisList?.currentPage)! - 1,
        byDiagnosisId: widget.diagnosisId);
  }

  void _nextPage() {
    if (_anamnesisDiagnosisList?.currentPage ==
        _anamnesisDiagnosisList?.lastPage) return;
    _getList(
        page: (_anamnesisDiagnosisList?.currentPage)! + 1,
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
                page: _anamnesisDiagnosisList?.currentPage as int,
                pageSize: _anamnesisDiagnosisList?.perPage as int,
                byDiagnosisId: widget.diagnosisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_anamnesisDiagnosisList?.data.isEmpty == true)
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
                              DataColumn(label: Text("Atanan")),
                              DataColumn(label: Text("Onaylan")),
                              DataColumn(label: Text("Oluşturulma")),
                              DataColumn(label: Text("Güncellenme"))
                            ],
                            rows: AnamnesisDiagnosesListDataTableRow(
                                context, _anamnesisDiagnosisList?.data,
                                onBack: () => _getList(
                                    page: _anamnesisDiagnosisList?.currentPage
                                        as int,
                                    pageSize:
                                        _anamnesisDiagnosisList?.perPage as int,
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
                              'Sayfa: ${_anamnesisDiagnosisList?.currentPage}'),
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
