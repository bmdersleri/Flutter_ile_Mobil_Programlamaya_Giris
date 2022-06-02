import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/models/BacteriologicAnalysesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/models/BacteriologicAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/services/BacteriologicAnalysesService.dart';

class BacteriologicAnalysisListWidget extends StatefulWidget {
  final BacteriologicAnalysesService _bacteriologicAnalysesService =
      BacteriologicAnalysesService();
  String? analysisId;

  BacteriologicAnalysisListWidget({Key? key, this.analysisId})
      : super(key: key);

  @override
  _BacteriologicAnalysisListWidgetState createState() {
    return _BacteriologicAnalysisListWidgetState();
  }
}

class _BacteriologicAnalysisListWidgetState
    extends State<BacteriologicAnalysisListWidget> {
  bool _isLoading = true;
  BacteriologicAnalysisListModel? _bacteriologicAnalysisList;

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

    var result = await widget._bacteriologicAnalysesService
        .getList(page: page, pageSize: pageSize, byAnalysisId: byAnalysisId);

    setState(() {
      _bacteriologicAnalysisList =
          BacteriologicAnalysisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_bacteriologicAnalysisList?.currentPage == 1) return;
    _getList(
        page: (_bacteriologicAnalysisList?.currentPage)! - 1,
        byAnalysisId: widget.analysisId);
  }

  void _nextPage() {
    if (_bacteriologicAnalysisList?.currentPage ==
        _bacteriologicAnalysisList?.lastPage) return;
    _getList(
        page: (_bacteriologicAnalysisList?.currentPage)! + 1,
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
                page: _bacteriologicAnalysisList?.currentPage as int,
                pageSize: _bacteriologicAnalysisList?.perPage as int,
                byAnalysisId: widget.analysisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_bacteriologicAnalysisList?.data.isEmpty == true)
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
                            rows: BacteriologicAnalysesListDataTableRow(
                                context, _bacteriologicAnalysisList?.data,
                                onBack: () => _getList(
                                    page: _bacteriologicAnalysisList
                                        ?.currentPage as int,
                                    pageSize: _bacteriologicAnalysisList
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
                              'Sayfa: ${_bacteriologicAnalysisList?.currentPage}'),
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
