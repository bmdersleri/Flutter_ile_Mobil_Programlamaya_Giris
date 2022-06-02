import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/models/MicroscopicDiagnosesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/models/MicroscopicDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/services/MicroscopicDiagnosesService.dart';

class MicroscopicDiagnosisListWidget extends StatefulWidget {
  final MicroscopicDiagnosesService _microscopicDiagnosesService =
      MicroscopicDiagnosesService();
  String? diagnosisId;

  MicroscopicDiagnosisListWidget({Key? key, this.diagnosisId})
      : super(key: key);

  @override
  _MicroscopicDiagnosisListWidgetState createState() {
    return _MicroscopicDiagnosisListWidgetState();
  }
}

class _MicroscopicDiagnosisListWidgetState
    extends State<MicroscopicDiagnosisListWidget> {
  bool _isLoading = true;
  MicroscopicDiagnosisListModel? _microscopicDiagnosisList;

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

    var result = await widget._microscopicDiagnosesService
        .getList(page: page, pageSize: pageSize, byDiagnosisId: byDiagnosisId);

    setState(() {
      _microscopicDiagnosisList =
          MicroscopicDiagnosisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_microscopicDiagnosisList?.currentPage == 1) return;
    _getList(
        page: (_microscopicDiagnosisList?.currentPage)! - 1,
        byDiagnosisId: widget.diagnosisId);
  }

  void _nextPage() {
    if (_microscopicDiagnosisList?.currentPage ==
        _microscopicDiagnosisList?.lastPage) return;
    _getList(
        page: (_microscopicDiagnosisList?.currentPage)! + 1,
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
                page: _microscopicDiagnosisList?.currentPage as int,
                pageSize: _microscopicDiagnosisList?.perPage as int,
                byDiagnosisId: widget.diagnosisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_microscopicDiagnosisList?.data.isEmpty == true)
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
                            rows: MicroscopicDiagnosesListDataTableRow(
                                context, _microscopicDiagnosisList?.data,
                                onBack: () => _getList(
                                    page: _microscopicDiagnosisList?.currentPage
                                        as int,
                                    pageSize: _microscopicDiagnosisList?.perPage
                                        as int,
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
                              'Sayfa: ${_microscopicDiagnosisList?.currentPage}'),
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
