import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/SpecimensListDataTableRow.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/SpecimensListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/services/SpecimensService.dart';

class SpecimensListWidget extends StatefulWidget {
  final SpecimensService _specimensService = SpecimensService();
  String? protocolNumber;

  SpecimensListWidget({Key? key, this.protocolNumber}) : super(key: key);

  @override
  _SpecimensListWidgetState createState() {
    return _SpecimensListWidgetState();
  }
}

class _SpecimensListWidgetState extends State<SpecimensListWidget> {
  bool _isLoading = true;
  SpecimenListModel? _specimenList;

  @override
  void initState() {
    super.initState();
    _getList(byProtocolNumber: widget.protocolNumber);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getList(
      {int page = 0, int pageSize = 10, String? byProtocolNumber}) async {
    setState(() {
      _isLoading = true;
    });

    var result = await widget._specimensService.getList(
        page: page, pageSize: pageSize, byProtocolNumber: byProtocolNumber);

    setState(() {
      _specimenList = SpecimenListModel.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  void _prevPage() {
    if (_specimenList?.currentPage == 1) return;
    _getList(
        page: (_specimenList?.currentPage)! - 1,
        byProtocolNumber: widget.protocolNumber);
  }

  void _nextPage() {
    if (_specimenList?.currentPage == _specimenList?.lastPage) return;
    _getList(
        page: (_specimenList?.currentPage)! + 1,
        byProtocolNumber: widget.protocolNumber);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => _getList(
                page: _specimenList?.currentPage as int,
                pageSize: _specimenList?.perPage as int,
                byProtocolNumber: widget.protocolNumber),
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                if (_specimenList?.data.isEmpty == true)
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
                              DataColumn(label: Text("Tür")),
                              DataColumn(label: Text("Yaş")),
                              DataColumn(label: Text("Cinsiyet")),
                              DataColumn(label: Text("Sahibi"))
                            ],
                            rows: SpecimensListDataTableRow(
                                context, _specimenList?.data,
                                onBack: () => _getList(
                                    page: _specimenList?.currentPage as int,
                                    pageSize: _specimenList?.perPage as int,
                                    byProtocolNumber:
                                        widget.protocolNumber)).rows),
                        scrollDirection: Axis.horizontal,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left_rounded),
                            onPressed: _prevPage,
                          ),
                          Text('Sayfa: ${_specimenList?.currentPage}'),
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
