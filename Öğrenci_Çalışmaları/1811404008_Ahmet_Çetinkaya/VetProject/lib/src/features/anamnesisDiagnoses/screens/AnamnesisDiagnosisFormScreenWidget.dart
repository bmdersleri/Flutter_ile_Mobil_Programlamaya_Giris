import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/models/AnamnesisDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/services/AnamnesisDiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/helpers/QuillHelper.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class AnamnesisDiagnosisFormScreenWidget extends StatefulWidget {
  int? id;
  String? diagnosisIdToAdd;

  final AnamnesisDiagnosesService _anamnesisDiagnosesService =
      AnamnesisDiagnosesService();
  final StatusTypeService _statusTypesService = StatusTypeService();
  final UserService _usersService = UserService();

  AnamnesisDiagnosisFormScreenWidget({Key? key, this.id, this.diagnosisIdToAdd})
      : super(key: key);

  @override
  _AnamnesisDiagnosisFormScreenWidgetState createState() {
    return _AnamnesisDiagnosisFormScreenWidgetState();
  }
}

class _AnamnesisDiagnosisFormScreenWidgetState
    extends State<AnamnesisDiagnosisFormScreenWidget> {
  AnamnesisDiagnosis? _anamnesisDiagnosis;
  final List<StatusType> _statusTypes = [];
  final List<User> _users = [];

  bool _isConfiguredForm = false;
  bool _isEditing = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  quill.QuillController _quillController = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();

    _configureEditOrCreateForm();
    _getAllStatusTypes();
    _getAllUsers();
  }

  void _configureEditOrCreateForm() {
    if (_isConfiguredForm) return;
    _isConfiguredForm = true;

    if (widget.id != null) {
      // Edit
      setState(() {
        _isEditing = true;
        _isLoading = true;
      });

      if (_anamnesisDiagnosis == null) {
        _getById(widget.id as int);
      }
    } else {
      // Create
      _anamnesisDiagnosis =
          AnamnesisDiagnosis(diagnosisId: widget.diagnosisIdToAdd, statusId: 1);
    }
  }

  Future _getById(int id) async {
    var result = await widget._anamnesisDiagnosesService.getById(id);
    if (!mounted) return;
    setState(() {
      _anamnesisDiagnosis =
          AnamnesisDiagnosis.fromJson(jsonDecode(result.body));
      if (_anamnesisDiagnosis?.anamnesisDiagnosis != null &&
          _anamnesisDiagnosis?.anamnesisDiagnosis?.isNotEmpty == true &&
          _anamnesisDiagnosis?.anamnesisDiagnosis != "\n") {
        _quillController = quill.QuillController(
            document: quill.Document.fromDelta(QuillHelper.htmlToDelta(
                _anamnesisDiagnosis?.anamnesisDiagnosis as String)),
            selection: const TextSelection.collapsed(offset: 0));
      }
      _isLoading = false;
    });
  }

  Future _getAllStatusTypes() async {
    var result =
        await widget._statusTypesService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _statusTypes.addAll(((body['data'] as List)
          .map((data) => StatusType.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  Future _getAllUsers() async {
    var result = await widget._usersService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _users.addAll(((body['data'] as List)
          .map((data) => User.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  void _save() {
    _anamnesisDiagnosis?.anamnesisDiagnosis =
        QuillHelper.deltaToHtml(_quillController.document.toDelta());
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result =
        await widget._anamnesisDiagnosesService.create(_anamnesisDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Anamnez Bulgu eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    Map<String, dynamic> body = jsonDecode(result.body);
    await _getById(body["id"] as int);
  }

  Future _update() async {
    Response result =
        await widget._anamnesisDiagnosesService.update(_anamnesisDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Anamnez Bulgu güncellendi.");
    await _getById(_anamnesisDiagnosis?.id as int);
  }

  Future _approve() async {
    _anamnesisDiagnosis?.approvedByUserId = 1;

    Response result =
        await widget._anamnesisDiagnosesService.approve(_anamnesisDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Anamnez Bulgu onaylandı.");
    await _getById(_anamnesisDiagnosis?.id as int);
  }

  Future _delete() async {
    Response result =
        await widget._anamnesisDiagnosesService.delete(_anamnesisDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Anamnez Bulgu silindi.");
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${_anamnesisDiagnosis?.id != null ? '${_anamnesisDiagnosis?.id} -' : ''} Anamnez Bulgu Kaydı'),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Sil"),
                        enabled: _isEditing,
                        onTap: () => Future.delayed(
                            const Duration(seconds: 0),
                            () => DialogService.showConfirmDialog(context,
                                title: 'Silmek İstediğinize Emin Misiniz?',
                                onConfirm: _delete)),
                      ),
                      PopupMenuItem(
                        child: const Text("Onayla"),
                        enabled: _isEditing &&
                            _anamnesisDiagnosis?.approvedByUserId == null,
                        onTap: _approve,
                      )
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
                      //# GENUS
                      DropdownSearch<StatusType>(
                        items: _statusTypes,
                        selectedItem: _anamnesisDiagnosis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _anamnesisDiagnosis?.statusId)
                            : null,
                        onChanged: (e) => setState(
                            () => _anamnesisDiagnosis?.statusId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# ASSIGNEE USER
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _anamnesisDiagnosis != null
                            ? _users.firstWhereOrNull((e) =>
                                e.id == _anamnesisDiagnosis?.assigneeUserId)
                            : null,
                        onChanged: (e) => setState(
                            () => _anamnesisDiagnosis?.assigneeUserId = e?.id),
                        itemAsString: (e) => "${e?.firstName} ${e?.lastName}",
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Atanan Kişi",
                            prefixIcon: Icon(Icons.person)),
                      ),

                      //# Report Field
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 16, 16, 5),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.insert_drive_file,
                                color: Color.fromARGB(255, 137, 137, 137),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Text("Rapor"),
                              )
                            ],
                          ),
                        ),
                        quill.QuillToolbar.basic(
                          controller: _quillController,
                          multiRowsDisplay: false,
                          showInlineCode: false,
                          showCodeBlock: false,
                          showImageButton: false,
                          showVideoButton: false,
                          showColorButton: false,
                          showBackgroundColorButton: false,
                          showListCheck: false,
                          showIndent: false,
                          showUnderLineButton: false,
                          showStrikeThrough: false,
                          //
                          iconTheme: const quill.QuillIconTheme(
                              iconSelectedFillColor: ThemeColors.primary),
                        ),
                        const Divider(
                            color: Color.fromARGB(100, 137, 137, 137)),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: quill.QuillEditor(
                                controller: _quillController,
                                scrollController: ScrollController(),
                                scrollable: true,
                                expands: false,
                                focusNode: FocusNode(),
                                autoFocus: false,
                                readOnly: false,
                                padding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                            color: Color.fromARGB(255, 137, 137, 137)),
                      ]),
                    ],
                  ),
                ),
              ));
  }
}
