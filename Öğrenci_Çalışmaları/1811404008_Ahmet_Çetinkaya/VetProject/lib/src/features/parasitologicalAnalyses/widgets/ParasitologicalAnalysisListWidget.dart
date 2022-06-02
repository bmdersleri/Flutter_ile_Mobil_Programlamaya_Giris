import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/models/ParasitologicalAnalysesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/models/ParasitologicalAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/services/ParasitologicalAnalysesService.dart';

class ParasitologicalAnalysisListWidget extends StatefulWidget {
  final ParasitologicalAnalysesService _parasitologicalAnalysesService =
      ParasitologicalAnalysesService();
  String? analysisId;

  ParasitologicalAnalysisListWidget({Key? key, this.analysisId})
      : super(key: key);

  @override
  _ParasitologicalAnalysisListWidgetState createState() {
    return _ParasitologicalAnalysisListWidgetState();
  }
}

class _ParasitologicalAnalysisListWidgetState
    extends State<ParasitologicalAnalysisListWidget> {
  bool _isLoading = true;
  ParasitologicalAnalysisListModel? _parasitologicalAnalysisList;

  @override
  void initState() {
    super.initState();
    _getList(byAnalysisId: widget.analysisId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getList(
      {int page = 0, int pageSize = 10, String? byAnalysisId}) async {
    setState(() {
      _isLoading = true;
    });

    var result = await widget._parasitologicalAnalysesService
        .getList(page: page, pageSize: pageSize, byAnalysisId: byAnalysisId);

    setState(() {
      _parasitologicalAnalysisList =
          ParasitologicalAnalysisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_parasitologicalAnalysisList?.currentPage == 1) return;
    _getList(
        page: (_parasitologicalAnalysisList?.currentPage)! - 1,
        byAnalysisId: widget.analysisId);
  }

  void _nextPage() {
    if (_parasitologicalAnalysisList?.currentPage ==
        _parasitologicalAnalysisList?.lastPage) return;
    _getList(
        page: (_parasitologicalAnalysisList?.currentPage)! + 1,
        byAnalysisId: widget.analysisId);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => _getList(
                page: _parasitologicalAnalysisList?.currentPage as int,
                pageSize: _parasitologicalAnalysisList?.perPage as int,
                byAnalysisId: widget.analysisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_parasitologicalAnalysisList?.data.isEmpty == true)
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
                            rows: ParasitologicalAnalysesListDataTableRow(
                                context, _parasitologicalAnalysisList?.data,
                                onBack: () => _getList(
                                    page: _parasitologicalAnalysisList
                                        ?.currentPage as int,
                                    pageSize: _parasitologicalAnalysisList
                                        ?.perPage as int,
                                    byAnalysisId: widget.analysisId)).rows),
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
                              'Sayfa: ${_parasitologicalAnalysisList?.currentPage}'),
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
