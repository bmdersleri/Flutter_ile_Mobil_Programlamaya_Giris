import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/services/MacroscopicDiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/widgets/MacroscopicDiagnosesGallery.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/helpers/QuillHelper.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/pages/CameraScreen.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class MacroscopicDiagnosisFormScreenWidget extends StatefulWidget {
  int? id;
  String? diagnosisIdToAdd;

  final MacroscopicDiagnosesService _macroscopicDiagnosesService =
      MacroscopicDiagnosesService();
  final StatusTypeService _statusTypesService = StatusTypeService();
  final UserService _usersService = UserService();

  MacroscopicDiagnosisFormScreenWidget(
      {Key? key, this.id, this.diagnosisIdToAdd})
      : super(key: key);

  @override
  _MacroscopicDiagnosisFormScreenWidgetState createState() {
    return _MacroscopicDiagnosisFormScreenWidgetState();
  }
}

class _MacroscopicDiagnosisFormScreenWidgetState
    extends State<MacroscopicDiagnosisFormScreenWidget> {
  MacroscopicDiagnosis? _macroscopicDiagnosis;
  final List<StatusType> _statusTypes = [];
  final List<User> _users = [];

  bool _isConfiguredForm = false;
  bool _isEditing = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  quill.QuillController _quillController = quill.QuillController.basic();
  final List<XFile> _filesToUpload = [];

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

      if (_macroscopicDiagnosis == null) {
        _getById(widget.id as int);
      }
    } else {
      // Create
      _macroscopicDiagnosis = MacroscopicDiagnosis(
          diagnosisId: widget.diagnosisIdToAdd, statusId: 1);
    }
  }

  Future _getById(int id) async {
    var result = await widget._macroscopicDiagnosesService.getById(id);
    if (!mounted) return;
    setState(() {
      _macroscopicDiagnosis =
          MacroscopicDiagnosis.fromJson(jsonDecode(result.body));
      if (_macroscopicDiagnosis?.macroscopicDiagnosis != null &&
          _macroscopicDiagnosis?.macroscopicDiagnosis?.isNotEmpty == true &&
          _macroscopicDiagnosis?.macroscopicDiagnosis != "\n") {
        _quillController = quill.QuillController(
            document: quill.Document.fromDelta(QuillHelper.htmlToDelta(
                _macroscopicDiagnosis?.macroscopicDiagnosis as String)),
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
    _macroscopicDiagnosis?.macroscopicDiagnosis =
        QuillHelper.deltaToHtml(_quillController.document.toDelta());
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result = await widget._macroscopicDiagnosesService
        .create(_macroscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Makroskobik Bulgu eklendi.");
    if (!mounted) return;
    Map<String, dynamic> body = jsonDecode(result.body);
    await _getById(body["id"] as int);
    setState(() {
      _isEditing = true;
    });
  }

  Future _update() async {
    Response result = await widget._macroscopicDiagnosesService
        .update(_macroscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Makroskobik Bulgu güncellendi.");
    await _getById(_macroscopicDiagnosis?.id as int);
    if (_filesToUpload.isNotEmpty) _uploadFiles();
  }

  Future _approve() async {
    _macroscopicDiagnosis?.approvedByUserId = 1;

    Response result = await widget._macroscopicDiagnosesService
        .approve(_macroscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Makroskobik Bulgu onaylandı.");
    await _getById(_macroscopicDiagnosis?.id as int);
  }

  Future _delete() async {
    Response result = await widget._macroscopicDiagnosesService
        .delete(_macroscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Makroskobik Bulgu silindi.");
    Navigator.pop(context);
  }

  Future _uploadFiles() async {
    ToastService.showSnackBar(context, "Makroskopik fotoğraflar yükleniyor...");
    List<XFile> _uploadedFiles = [];
    for (var file in _filesToUpload) {
      var result = await widget._macroscopicDiagnosesService
          .uploadFile(_macroscopicDiagnosis!, file);

      if (result.statusCode != HttpStatus.ok) {
        ToastService.showSnackBar(
            context, "Makroskopik fotoğraf yüklenirken bir sorun oluştu");
        return;
      }
      _uploadedFiles.add(file);
    }
    ToastService.showSnackBar(context, "Makroskopik fotoğraflar yüklendi.");

    setState(() {
      _filesToUpload.removeWhere((file) =>
          file ==
          _uploadedFiles
              .firstWhereOrNull((deletedFile) => deletedFile == file));
    });
  }

  Future _openCamera() async {
    XFile? result = await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
            builder: (BuildContext context) => const CameraScreen(),
            fullscreenDialog: true));
    if (result == null) return;

    setState(() {
      _filesToUpload.add(result);
    });
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
              '${_macroscopicDiagnosis?.id != null ? '${_macroscopicDiagnosis?.id} -' : ''} Makroskobik Bulgu Kaydı'),
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
                            _macroscopicDiagnosis?.approvedByUser == null,
                        onTap: _approve,
                      )
                    ]),
            IconButton(icon: const Icon(Icons.save), onPressed: _save),
          ],
        ),
        floatingActionButton: _isEditing && deviceCameras.isNotEmpty
            ? FloatingActionButton(
                onPressed: _openCamera,
                child: const Icon(Icons.camera_alt),
                heroTag: "addMacroscopicImageButton")
            : null,
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
                        selectedItem: _macroscopicDiagnosis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _macroscopicDiagnosis?.statusId)
                            : null,
                        onChanged: (e) => setState(
                            () => _macroscopicDiagnosis?.statusId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# ASSIGNEE USER
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _macroscopicDiagnosis != null
                            ? _users.firstWhereOrNull((e) =>
                                e.id == _macroscopicDiagnosis?.assigneeUserId)
                            : null,
                        onChanged: (e) => setState(() =>
                            _macroscopicDiagnosis?.assigneeUserId = e?.id),
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

                      //# MacroscopicDiagnosesGallery
                      if (_macroscopicDiagnosis != null && _isEditing)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 16, 16, 0),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.camera_alt,
                                    color: Color.fromARGB(255, 137, 137, 137),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                                    child: Text("Makroskopik Görüntüler"),
                                  )
                                ],
                              ),
                            ),
                            MacroscopicDiagnosesGallery(
                              macroscopicDiagnosis: _macroscopicDiagnosis,
                              filesToUpload: _filesToUpload,
                            )
                          ],
                        )
                    ],
                  ),
                ),
              ));
  }
}
