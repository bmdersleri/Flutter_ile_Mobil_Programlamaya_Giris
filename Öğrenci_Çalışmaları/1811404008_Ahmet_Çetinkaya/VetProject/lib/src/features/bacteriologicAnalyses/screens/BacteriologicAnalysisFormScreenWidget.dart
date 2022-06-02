import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/models/BacteriologicAnalysis.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/services/BacteriologicAnalysesService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/helpers/QuillHelper.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class BacteriologicAnalysisFormScreenWidget extends StatefulWidget {
  int? id;
  String? analysisIdToAdd;

  final BacteriologicAnalysesService _bacteriologicAnalysesService =
      BacteriologicAnalysesService();
  final StatusTypeService _statusTypesService = StatusTypeService();
  final UserService _usersService = UserService();

  BacteriologicAnalysisFormScreenWidget(
      {Key? key, this.id, this.analysisIdToAdd})
      : super(key: key);

  @override
  _BacteriologicAnalysisFormScreenWidgetState createState() {
    return _BacteriologicAnalysisFormScreenWidgetState();
  }
}

class _BacteriologicAnalysisFormScreenWidgetState
    extends State<BacteriologicAnalysisFormScreenWidget> {
  BacteriologicAnalysis? _bacteriologicAnalysis;
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

      if (_bacteriologicAnalysis == null) {
        _getById(widget.id as int);
      }
    } else {
      // Create
      _bacteriologicAnalysis = BacteriologicAnalysis(
          analysisId: widget.analysisIdToAdd, statusId: 1);
    }
  }

  Future _getById(int id) async {
    var result = await widget._bacteriologicAnalysesService.getById(id);
    if (!mounted) return;
    setState(() {
      _bacteriologicAnalysis =
          BacteriologicAnalysis.fromJson(jsonDecode(result.body));
      if (_bacteriologicAnalysis?.bacteriologicAnalysis != null &&
          _bacteriologicAnalysis?.bacteriologicAnalysis?.isNotEmpty == true &&
          _bacteriologicAnalysis?.bacteriologicAnalysis != "\n") {
        _quillController = quill.QuillController(
            document: quill.Document.fromDelta(QuillHelper.htmlToDelta(
                _bacteriologicAnalysis?.bacteriologicAnalysis as String)),
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
    _bacteriologicAnalysis?.bacteriologicAnalysis =
        QuillHelper.deltaToHtml(_quillController.document.toDelta());
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result = await widget._bacteriologicAnalysesService
        .create(_bacteriologicAnalysis!);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Bakteriyolojik Analiz eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    Map<String, dynamic> body = jsonDecode(result.body);
    await _getById(body["id"] as int);
  }

  Future _update() async {
    Response result = await widget._bacteriologicAnalysesService
        .update(_bacteriologicAnalysis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bakteriyolojik Analiz güncellendi.");
    await _getById(_bacteriologicAnalysis?.id as int);
  }

  Future _approve() async {
    _bacteriologicAnalysis?.approvedByUserId = 1;

    Response result = await widget._bacteriologicAnalysesService
        .approve(_bacteriologicAnalysis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bakteriyolojik Analiz onaylandı.");
    await _getById(_bacteriologicAnalysis?.id as int);
  }

  Future _delete() async {
    Response result = await widget._bacteriologicAnalysesService
        .delete(_bacteriologicAnalysis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Bakteriyolojik Analiz silindi.");
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
              '${_bacteriologicAnalysis?.id != null ? '${_bacteriologicAnalysis?.id} -' : ''} Bakteriyolojik Analiz Kaydı'),
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
                            _bacteriologicAnalysis?.approvedByUserId == null,
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
                        selectedItem: _bacteriologicAnalysis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _bacteriologicAnalysis?.statusId)
                            : null,
                        onChanged: (e) => setState(
                            () => _bacteriologicAnalysis?.statusId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# ASSIGNEE USER
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _bacteriologicAnalysis != null
                            ? _users.firstWhereOrNull((e) =>
                                e.id == _bacteriologicAnalysis?.assigneeUserId)
                            : null,
                        onChanged: (e) => setState(() =>
                            _bacteriologicAnalysis?.assigneeUserId = e?.id),
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
