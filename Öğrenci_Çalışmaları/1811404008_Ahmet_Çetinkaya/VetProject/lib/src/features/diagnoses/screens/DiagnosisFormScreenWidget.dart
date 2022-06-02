import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/models/Diagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/services/DiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/diseaseTypes/models/DiseaseType.dart';
import 'package:vet_project_flutter_frontend/src/features/diseaseTypes/services/DiseaseTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';

class DiagnosisFormScreenWidget extends StatefulWidget {
  String pathologyReportId;

  final DiagnosesService _diagnosesService = DiagnosesService();
  final StatusTypeService _statusTypeService = StatusTypeService();
  final DiseaseTypeService _diseaseTypeService = DiseaseTypeService();
  final UserService _userService = UserService();

  DiagnosisFormScreenWidget({Key? key, required this.pathologyReportId})
      : super(key: key);

  @override
  _DiagnosisFormScreenWidgetState createState() {
    return _DiagnosisFormScreenWidgetState();
  }
}

class _DiagnosisFormScreenWidgetState extends State<DiagnosisFormScreenWidget> {
  Diagnosis? _diagnosis;
  final List<StatusType> _statusTypes = [];
  final List<DiseaseType> _diseaseTypes = [];
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
    _getAllDiseaseTypes();
    _getAllUsers();
  }

  void _configureEditOrCreateForm() {
    if (_isConfiguredForm) return;
    _isConfiguredForm = true;

    if (_diagnosis != null) {
      // Edit
      setState(() {
        _isEditing = true;
      });
    } else {
      // Create
      _diagnosis = Diagnosis(pathologyReportId: widget.pathologyReportId);
    }
  }

  Future _getById(String id) async {
    _isLoading = true;
    var result = await widget._diagnosesService.getById(id);
    if (!mounted) return;
    setState(() {
      dynamic body = jsonDecode(result.body);
      if (body['pathology_report_id'] != null) {
        _diagnosis = Diagnosis.fromJson(body);
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

  Future _getAllDiseaseTypes() async {
    var result =
        await widget._diseaseTypeService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _diseaseTypes.addAll(((body['data'] as List)
          .map((data) => DiseaseType.fromJson(jsonDecode(jsonEncode(data))))));
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
        await widget._diagnosesService.create(_diagnosis as Diagnosis);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bulgu kaydı eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    await _getById(_diagnosis?.pathologyReportId as String);
  }

  Future _update() async {
    Response result = await widget._diagnosesService.update(_diagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bulgu kaydı güncellendi.");
    await _getById(_diagnosis?.pathologyReportId as String);
  }

  Future _approve() async {
    _diagnosis?.approvedByUserId = 1; 
    Response result = await widget._diagnosesService.approve(_diagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bulgu raporu onaylandı.");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_diagnosis?.pathologyReportId ?? ''} Bulgu Kaydı'),
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
                        selectedItem: _diagnosis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _diagnosis?.statusId)
                            : null,
                        onChanged: (e) =>
                            setState(() => _diagnosis?.statusId = e?.id),
                        itemAsString: (e) => e?.name ?? '',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# Disease Type Field
                      DropdownSearch<DiseaseType>(
                        items: _diseaseTypes,
                        selectedItem: _diagnosis != null
                            ? _diseaseTypes.firstWhereOrNull(
                                (e) => e.id == _diagnosis?.diseaseTypeId)
                            : null,
                        onChanged: (e) =>
                            setState(() => _diagnosis?.diseaseTypeId = e?.id),
                        itemAsString: (e) => e?.name ?? '',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Hastalık Türü",
                            prefixIcon: Icon(Icons.label)),
                      ),

                      //# Assignee User Field
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _diagnosis != null
                            ? _users.firstWhereOrNull(
                                (e) => e.id == _diagnosis?.assigneeUserId)
                            : null,
                        onChanged: (e) =>
                            setState(() => _diagnosis?.assigneeUserId = e?.id),
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
