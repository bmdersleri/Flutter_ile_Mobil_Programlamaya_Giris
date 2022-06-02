import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/models/MicroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/services/MicroscopicDiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/widgets/MicroscopicDiagnosesGallery.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/helpers/QuillHelper.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class MicroscopicDiagnosisFormScreenWidget extends StatefulWidget {
  int? id;
  String? diagnosisIdToAdd;

  final MicroscopicDiagnosesService _microscopicDiagnosesService =
      MicroscopicDiagnosesService();
  final StatusTypeService _statusTypesService = StatusTypeService();
  final UserService _usersService = UserService();
  final ImagePicker _imagePicker = ImagePicker();

  MicroscopicDiagnosisFormScreenWidget(
      {Key? key, this.id, this.diagnosisIdToAdd})
      : super(key: key);

  @override
  _MicroscopicDiagnosisFormScreenWidgetState createState() {
    return _MicroscopicDiagnosisFormScreenWidgetState();
  }
}

class _MicroscopicDiagnosisFormScreenWidgetState
    extends State<MicroscopicDiagnosisFormScreenWidget> {
  MicroscopicDiagnosis? _microscopicDiagnosis;
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

      if (_microscopicDiagnosis == null) {
        _getById(widget.id as int);
      }
    } else {
      // Create
      _microscopicDiagnosis = MicroscopicDiagnosis(
          diagnosisId: widget.diagnosisIdToAdd, statusId: 1);
    }
  }

  Future _getById(int id) async {
    var result = await widget._microscopicDiagnosesService.getById(id);
    if (!mounted) return;
    setState(() {
      _microscopicDiagnosis =
          MicroscopicDiagnosis.fromJson(jsonDecode(result.body));
      if (_microscopicDiagnosis?.microscopicDiagnosis != null &&
          _microscopicDiagnosis?.microscopicDiagnosis?.isNotEmpty == true &&
          _microscopicDiagnosis?.microscopicDiagnosis != "\n") {
        _quillController = quill.QuillController(
            document: quill.Document.fromDelta(QuillHelper.htmlToDelta(
                _microscopicDiagnosis?.microscopicDiagnosis as String)),
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
    _microscopicDiagnosis?.microscopicDiagnosis =
        QuillHelper.deltaToHtml(_quillController.document.toDelta());
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result = await widget._microscopicDiagnosesService
        .create(_microscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Mikroskobik Bulgu eklendi.");
    if (!mounted) return;
    Map<String, dynamic> body = jsonDecode(result.body);
    await _getById(body["id"] as int);
    setState(() {
      _isEditing = true;
    });
  }

  Future _update() async {
    Response result = await widget._microscopicDiagnosesService
        .update(_microscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Mikroskobik Bulgu güncellendi.");
    await _getById(_microscopicDiagnosis?.id as int);
    if (_filesToUpload.isNotEmpty) _uploadFiles();
  }

  Future _approve() async {
    _microscopicDiagnosis?.approvedByUserId = 1;

    Response result = await widget._microscopicDiagnosesService
        .approve(_microscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Mikroskobik Bulgu onaylandı.");
    await _getById(_microscopicDiagnosis?.id as int);
  }

  Future _delete() async {
    Response result = await widget._microscopicDiagnosesService
        .delete(_microscopicDiagnosis!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Mikroskobik Bulgu silindi.");
    Navigator.pop(context);
  }

  Future _uploadFiles() async {
    ToastService.showSnackBar(context, "Mikroskopik fotoğraflar yükleniyor...");
    List<XFile> _uploadedFiles = [];
    for (var file in _filesToUpload) {
      var result = await widget._microscopicDiagnosesService
          .uploadFile(_microscopicDiagnosis!, file);

      if (result.statusCode != HttpStatus.ok) {
        ToastService.showSnackBar(
            context, "Mikroskopik fotoğraf yüklenirken bir sorun oluştu");
        return;
      }
      _uploadedFiles.add(file);
    }
    ToastService.showSnackBar(context, "Mikroskopik fotoğraflar yüklendi.");

    setState(() {
      _filesToUpload.removeWhere((file) =>
          file ==
          _uploadedFiles
              .firstWhereOrNull((deletedFile) => deletedFile == file));
    });
  }

  Future _openGallery() async {
    final List<XFile>? files = await widget._imagePicker.pickMultiImage();

    if (files != null && files.isNotEmpty == true) {
      setState(() {
        _filesToUpload.addAll(files);
      });
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
          title: Text(
              '${_microscopicDiagnosis?.id != null ? '${_microscopicDiagnosis?.id} -' : ''} Mikroskobik Bulgu Kaydı'),
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
                            _microscopicDiagnosis?.approvedByUserId == null,
                        onTap: _approve,
                      )
                    ]),
            IconButton(icon: const Icon(Icons.save), onPressed: _save),
          ],
        ),
        floatingActionButton: _isEditing && deviceCameras.isNotEmpty
            ? FloatingActionButton(
                onPressed: _openGallery,
                child: const Icon(Icons.image),
                heroTag: "addMicroscopicImageButton")
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
                        selectedItem: _microscopicDiagnosis != null
                            ? _statusTypes.firstWhereOrNull(
                                (e) => e.id == _microscopicDiagnosis?.statusId)
                            : null,
                        onChanged: (e) => setState(
                            () => _microscopicDiagnosis?.statusId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(
                            labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# ASSIGNEE USER
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _microscopicDiagnosis != null
                            ? _users.firstWhereOrNull((e) =>
                                e.id == _microscopicDiagnosis?.assigneeUserId)
                            : null,
                        onChanged: (e) => setState(() =>
                            _microscopicDiagnosis?.assigneeUserId = e?.id),
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

                      //# MicroscopicDiagnosesGallery
                      if (_microscopicDiagnosis != null && _isEditing)
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
                                    child: Text("Mikroskopik Görüntüler"),
                                  )
                                ],
                              ),
                            ),
                            MicroscopicDiagnosesGallery(
                              microscopicDiagnosis: _microscopicDiagnosis,
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
