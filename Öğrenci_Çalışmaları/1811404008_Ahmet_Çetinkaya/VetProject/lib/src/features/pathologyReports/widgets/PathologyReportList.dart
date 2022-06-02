import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReportListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReportListModel.dart';

import '../services/PathologyReportService.dart';

class PathologyReportList extends StatefulWidget {
  final PathologyReportService _pathologyReportService = PathologyReportService();

  PathologyReportList({Key? key}) : super(key: key);

  @override
  _PathologyReportListState createState() {
    return _PathologyReportListState();
  }
}

class _PathologyReportListState extends State<PathologyReportList> {
  bool _isLoading = true;
  PathologyReportListModel? _pathologyReportList;
  String? _protocolNumberSearchText;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getList({int page = 0, int pageSize = 10, byProtocolNumber}) async {
    setState(() {
      _isLoading = true;
    });

    var result = await widget._pathologyReportService.getList(page: page, pageSize: pageSize, byProtocolNumber: byProtocolNumber);

    setState(() {
      _pathologyReportList = PathologyReportListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_pathologyReportList?.currentPage == 1) return;
    _getList(page: (_pathologyReportList?.currentPage)! - 1, byProtocolNumber: _protocolNumberSearchText);
  }

  void _nextPage() {
    if (_pathologyReportList?.currentPage == _pathologyReportList?.lastPage) {
      return;
    }
    _getList(page: (_pathologyReportList?.currentPage)! + 1, byProtocolNumber: _protocolNumberSearchText);
  }

  void search(String text) {
    _protocolNumberSearchText = text;
    _getList(byProtocolNumber: _protocolNumberSearchText);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getList,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          TextField(
            onChanged: search,
            autofocus: false,
            decoration: const InputDecoration(hintText: 'Protokol numarası arayın', prefixIcon: Icon(Icons.search)),
          ),
          if (_isLoading)
            Column(
              children: const [
                SizedBox(
                  height: 250,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
          else if (_pathologyReportList?.data.isEmpty == true)
            const Center(child: Text("Kayıt Yok."))
          else
            Column(
              children: [
                SingleChildScrollView(
                  child: DataTable(columns: const [DataColumn(label: Text("No")), DataColumn(label: Text("Numune")), DataColumn(label: Text("Sahibi")), DataColumn(label: Text("Kabul Tarihi"))], rows: PathologyReportListDataTableRow(context, _pathologyReportList?.data, onBack: _getList).rows),
                  scrollDirection: Axis.horizontal,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left_rounded),
                      onPressed: _prevPage,
                    ),
                    Text('Sayfa: ${_pathologyReportList?.currentPage}'),
                    IconButton(icon: const Icon(Icons.chevron_right_rounded), onPressed: _nextPage)
                  ],
                )
              ],
            )
        ],
      ),
    );
  }
}
