import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/models/Analysis.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/services/AnalysesService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';

class AnalysisFormScreenWidget extends StatefulWidget {
  String pathologyReportId;

  final AnalysesService _analysesService = AnalysesService();
  final StatusTypeService _statusTypeService = StatusTypeService();
  final UserService _userService = UserService();

  AnalysisFormScreenWidget({Key? key, required this.pathologyReportId})
      : super(key: key);

  @override
  _AnalysisFormScreenWidgetState createState() {
    return _AnalysisFormScreenWidgetState();
  }
}

class _AnalysisFormScreenWidgetState extends State<AnalysisFormScreenWidget> {
  Analysis? _analysis;
  final List<StatusType> _statusTypes = [];
  final List<User> _users = [];

  bool _isConfiguredForm = false;
  bool _isEditing = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _getById(widget.pathologyReportId);
    _getAllStatusTypes();
    _getAllUsers();
  }

  void _configureEditOrCreateForm() {
    if (_isConfiguredForm) return;
    _isConfiguredForm = true;

    if (_analysis != null) {
      // Edit
      setState(() {
        _isEditing = true;
      });
    } else {
      // Create
      _analysis = Analysis(pathologyReportId: widget.pathologyReportId);
    }
  }

  Future _getById(String id) async {
    _isLoading = true;
    var result = await widget._analysesService.getById(id);
    if (!mounted) return;
    setState(() {
      dynamic body = jsonDecode(result.body);
      if (body['pathology_report_id'] != null) {
        _analysis = Analysis.fromJson(body);
      }
      _isLoading = false;
      _configureEditOrCreateForm();
    });
  }

  Future _getAllStatusTypes() async {
    var result =
        await widget._statusTypeService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _statusTypes.addAll(((body['data'] as List)
          .map((data) => StatusType.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  Future _getAllUsers() async {
    var result = await widget._userService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _users.addAll(((body['data'] as List)
          .map((data) => User.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  void _save() {
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result =
        await widget._analysesService.create(_analysis as Analysis);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Analiz kaydı eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    await _getById(_analysis?.pathologyReportId as String);
  }

  Future _update() async {
    Response result = await widget._analysesService.update(_analysis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Analiz kaydı güncellendi.");
    await _getById(_analysis?.pathologyReportId as String);
  }

  Future _approve() async {
    _analysis?.approvedByUserId = 1;
    Response result = await widget._analysesService.approve(_analysis!);
    if (result.statusCode == HttpStatus.ok) {
      ToastService.showSnackBar(context, "Analiz raporu onaylandı.");
    } else {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_analysis?.pathologyReportId ?? ''} Analiz Kaydı'),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: _approve,
                        child: const Text("Onayla"),
                        enabled: _isEditing,
                      ),
                    ]),
            IconButton(icon: const Icon(Icons.save), onPressed: _save),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //# Status Type Field
                      DropdownSearch<StatusType>(
                        items: _statusTypes,
                        selectedItem: _analysis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _analysis?.statusId)
                            : null,
                        onChanged: (e) =>
                            setState(() => _analysis?.statusId = e?.id),
                        itemAsString: (e) => e?.name ?? '',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# Assignee User Field
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _analysis != null
                            ? _users.firstWhereOrNull(
                                (e) => e.id == _analysis?.assigneeUserId)
                            : null,
                        onChanged: (e) =>
                            setState(() => _analysis?.assigneeUserId = e?.id),
                        itemAsString: (e) => '${e?.firstName} ${e?.lastName}',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Atanan Kişi",
                            prefixIcon: Icon(Icons.person)),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
