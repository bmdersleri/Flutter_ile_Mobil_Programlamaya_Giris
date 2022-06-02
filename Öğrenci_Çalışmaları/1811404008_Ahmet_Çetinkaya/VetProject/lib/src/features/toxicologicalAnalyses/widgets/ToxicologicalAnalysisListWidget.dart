import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/models/ToxicologicalAnalysesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/models/ToxicologicalAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/services/ToxicologicalAnalysesService.dart';

class ToxicologicalAnalysisListWidget extends StatefulWidget {
  final ToxicologicalAnalysesService _toxicologicalAnalysesService =
      ToxicologicalAnalysesService();
  String? analysisId;

  ToxicologicalAnalysisListWidget({Key? key, this.analysisId})
      : super(key: key);

  @override
  _ToxicologicalAnalysisListWidgetState createState() {
    return _ToxicologicalAnalysisListWidgetState();
  }
}

class _ToxicologicalAnalysisListWidgetState
    extends State<ToxicologicalAnalysisListWidget> {
  bool _isLoading = true;
  ToxicologicalAnalysisListModel? _toxicologicalAnalysisList;

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

    var result = await widget._toxicologicalAnalysesService
        .getList(page: page, pageSize: pageSize, byAnalysisId: byAnalysisId);

    setState(() {
      _toxicologicalAnalysisList =
          ToxicologicalAnalysisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_toxicologicalAnalysisList?.currentPage == 1) return;
    _getList(
        page: (_toxicologicalAnalysisList?.currentPage)! - 1,
        byAnalysisId: widget.analysisId);
  }

  void _nextPage() {
    if (_toxicologicalAnalysisList?.currentPage ==
        _toxicologicalAnalysisList?.lastPage) return;
    _getList(
        page: (_toxicologicalAnalysisList?.currentPage)! + 1,
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
                page: _toxicologicalAnalysisList?.currentPage as int,
                pageSize: _toxicologicalAnalysisList?.perPage as int,
                byAnalysisId: widget.analysisId),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_toxicologicalAnalysisList?.data.isEmpty == true)
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
                            rows: ToxicologicalAnalysesListDataTableRow(
                                context, _toxicologicalAnalysisList?.data,
                                onBack: () => _getList(
                                    page: _toxicologicalAnalysisList
                                        ?.currentPage as int,
                                    pageSize: _toxicologicalAnalysisList
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
                              'Sayfa: ${_toxicologicalAnalysisList?.currentPage}'),
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
