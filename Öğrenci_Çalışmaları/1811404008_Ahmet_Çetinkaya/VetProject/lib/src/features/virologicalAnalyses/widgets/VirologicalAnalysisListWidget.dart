import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/models/VirologicalAnalysesListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/models/VirologicalAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/services/VirologicalAnalysesService.dart';

class VirologicalAnalysisListWidget extends StatefulWidget {
  final VirologicalAnalysesService _virologicalAnalysesService =
  VirologicalAnalysesService();
  String? analysisId;

  VirologicalAnalysisListWidget({Key? key, this.analysisId})
      : super(key: key);

  @override
  _VirologicalAnalysisListWidgetState createState() {
    return _VirologicalAnalysisListWidgetState();
  }
}

class _VirologicalAnalysisListWidgetState
    extends State<VirologicalAnalysisListWidget> {
  bool _isLoading = true;
  VirologicalAnalysisListModel? _virologicalAnalysisList;

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

    var result = await widget._virologicalAnalysesService
        .getList(page: page, pageSize: pageSize, byAnalysisId: byAnalysisId);

    setState(() {
      _virologicalAnalysisList =
          VirologicalAnalysisListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_virologicalAnalysisList?.currentPage == 1) return;
    _getList(
        page: (_virologicalAnalysisList?.currentPage)! - 1,
        byAnalysisId: widget.analysisId);
  }

  void _nextPage() {
    if (_virologicalAnalysisList?.currentPage ==
        _virologicalAnalysisList?.lastPage) return;
    _getList(
        page: (_virologicalAnalysisList?.currentPage)! + 1,
        byAnalysisId: widget.analysisId);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
      child: CircularProgressIndicator(),
    )
        : RefreshIndicator(
      onRefresh: () =>
          _getList(
              page: _virologicalAnalysisList?.currentPage as int,
              pageSize: _virologicalAnalysisList?.perPage as int,
              byAnalysisId: widget.analysisId),
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          if (_virologicalAnalysisList?.data.isEmpty == true)
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
                      rows: VirologicalAnalysesListDataTableRow(
                          context, _virologicalAnalysisList?.data,
                          onBack: () =>
                              _getList(
                                  page: _virologicalAnalysisList
                                      ?.currentPage as int,
                                  pageSize: _virologicalAnalysisList
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
                        'Sayfa: ${_virologicalAnalysisList?.currentPage}'),
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
