import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/examinationTypes/models/ExaminationType.dart';
import 'package:vet_project_flutter_frontend/src/features/examinationTypes/services/ExaminationTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReport.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/pages/PathologyReportScreenWidget.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/services/PathologyReportService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/helpers/QuillHelper.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/services/StatusTypeService.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/users/services/UserService.dart';
import 'package:vet_project_flutter_frontend/src/settings/ThemeColors.dart';

class PathologyReportFormPageWidget extends StatefulWidget {
  static const routeName = 'pathologyReport/add';
  String? protocolNumber;
  BuildContext? parentContext;

  final PathologyReportService _pathologyReportService = PathologyReportService();
  final ExaminationTypeService _examinationTypeService = ExaminationTypeService();
  final StatusTypeService _statusTypeService = StatusTypeService();
  final UserService _userService = UserService();

  PathologyReportFormPageWidget({Key? key, this.protocolNumber, this.parentContext}) : super(key: key);

  @override
  _PathologyReportFormPageWidgetState createState() {
    return _PathologyReportFormPageWidgetState();
  }
}

class _PathologyReportFormPageWidgetState extends State<PathologyReportFormPageWidget> {
  PathologyReport? _pathologyReport;

  final List<ExaminationType> _examinationTypes = [];
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
    _getAllExaminationTypes();
    _getAllStatusTypes();
    _getAllUsers();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _configureEditOrCreateForm() {
    if (_isConfiguredForm) return;
    _isConfiguredForm = true;

    if (widget.protocolNumber != null) {
      // Edit
      setState(() {
        _isEditing = true;
        _isLoading = true;
      });

      if (_pathologyReport == null) {
        _getByProtocolNumber(widget.protocolNumber as String);
      }
    } else {
      // Create
      _pathologyReport = PathologyReport(statusId: 1);
      _getNextOrderInYear();
    }
  }

  Future _getByProtocolNumber(String protocolNumber) async {
    var result = await widget._pathologyReportService.getByProtocolNumber(protocolNumber);
    if (!mounted) return;
    setState(() {
      _pathologyReport = PathologyReport.fromJson(jsonDecode(result.body));
      if (_pathologyReport?.report != null && (_pathologyReport?.report?.isNotEmpty == true && _pathologyReport?.report != "\n")) {
        _quillController = quill.QuillController(document: quill.Document.fromDelta(QuillHelper.htmlToDelta(_pathologyReport?.report as String)), selection: const TextSelection.collapsed(offset: 0));
      }
      _isLoading = false;
    });
  }

  Future _getNextOrderInYear() async {
    var result = await widget._pathologyReportService.nextOrderInYear();
    if (result.statusCode == HttpStatus.ok) {
      String yearNow = DateTime.now().year.toString().substring(2);
      if (!mounted) return;
      setState(() {
        _pathologyReport?.protocolNumber = '$yearNow/${int.parse(result.body) + 1}';
      });
    }
  }

  Future _getAllExaminationTypes() async {
    var result = await widget._examinationTypeService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _examinationTypes.addAll(((body['data'] as List).map((data) => ExaminationType.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  Future _getAllStatusTypes() async {
    var result = await widget._statusTypeService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _statusTypes.addAll(((body['data'] as List).map((data) => StatusType.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  Future _getAllUsers() async {
    var result = await widget._userService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _users.addAll(((body['data'] as List).map((data) => User.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  void _save() {
    _pathologyReport?.report = QuillHelper.deltaToHtml(_quillController.document.toDelta());
    if (_isEditing) {
      _update();
    } else {
      _create();
    }
  }

  Future _create() async {
    Response result = await widget._pathologyReportService.create(_pathologyReport!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Patoloji raporu eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    Navigator.pushReplacementNamed(context, PathologyReportScreenWidget.routeName, arguments: {'protocolNumber': _pathologyReport?.protocolNumber});
  }

  Future _update() async {
    Response result = await widget._pathologyReportService.update(_pathologyReport!);
    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Patoloji raporu güncellendi.");
    await _getByProtocolNumber(_pathologyReport?.protocolNumber as String);
  }

  Future _approve() async {
    _pathologyReport?.approvedByUserId = 1;
    Response result = await widget._pathologyReportService.approve(_pathologyReport!);

    if (result.statusCode == HttpStatus.ok) {
      ToastService.showSnackBar(context, "Patoloji raporu onaylandı.");
      await _getByProtocolNumber(_pathologyReport?.protocolNumber as String);
    } else {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
    }
  }

  Future _delete() async {
    Response result = await widget._pathologyReportService.delete(_pathologyReport!);

    if (result.statusCode == HttpStatus.ok) {
      ToastService.showSnackBar(context, "Patoloji raporu silindi.");
      Navigator.of(widget.parentContext as BuildContext).pop();
    } else {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
    }
  }

  Future<List<ExaminationType>> getExaminationTypeDropdownItems(String? filter) async {
    if (filter?.isEmpty == true) return _examinationTypes;

    return _examinationTypes.takeWhile((value) => value.name.toLowerCase().contains(filter?.toLowerCase() ?? '')).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_pathologyReport?.protocolNumber ?? ''} Patoloji Kaydı'),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Sil"),
                        enabled: _isEditing,
                        onTap: () => Future.delayed(const Duration(seconds: 0), () => DialogService.showConfirmDialog(context, title: 'Silmek İstediğinize Emin Misiniz?', onConfirm: _delete)),
                      ),
                      PopupMenuItem(
                        child: const Text("Onayla"),
                        enabled: _isEditing && _pathologyReport?.approvedByUser == null,
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
                      //# Protocol Number Field
                      TextFormField(
                        key: Key(_pathologyReport?.protocolNumber ?? ''),
                        initialValue: _pathologyReport?.protocolNumber,
                        enabled: !_isEditing,
                        onChanged: (value) => setState(() => _pathologyReport?.protocolNumber = value),
                        autofocus: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          labelText: "Protokol Numarası",
                          hintText: "22/xx",
                        ),
                      ),

                      //# Examination Type Field
                      DropdownSearch<ExaminationType>(
                        items: _examinationTypes,
                        selectedItem: _pathologyReport != null ? _examinationTypes.firstWhereOrNull((e) => e.id == _pathologyReport?.examinationTypeId) : null,
                        onChanged: (e) => setState(() => _pathologyReport?.examinationTypeId = e?.id),
                        itemAsString: (e) => e?.name ?? '',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "İnceleme Türü", prefixIcon: Icon(Icons.search)),
                      ),

                      //# Status Type Field
                      DropdownSearch<StatusType>(
                        items: _statusTypes,
                        selectedItem: _pathologyReport != null ? _statusTypes.firstWhereOrNull((e) => e.id == _pathologyReport?.statusId) : null,
                        onChanged: (e) => setState(() => _pathologyReport?.statusId = e?.id),
                        itemAsString: (e) => e?.name ?? '',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "Durum", prefixIcon: Icon(Icons.label)),
                      ),

                      //# Assignee User Field
                      DropdownSearch<User>(
                        items: _users,
                        selectedItem: _pathologyReport != null ? _users.firstWhereOrNull((e) => e.id == _pathologyReport?.assigneeUserId) : null,
                        onChanged: (e) => setState(() => _pathologyReport?.assigneeUserId = e?.id),
                        itemAsString: (e) => '${e?.firstName} ${e?.lastName}',
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "Atanan Kişi", prefixIcon: Icon(Icons.person)),
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
                          iconTheme: const quill.QuillIconTheme(iconSelectedFillColor: ThemeColors.primary),
                        ),
                        const Divider(color: Color.fromARGB(100, 137, 137, 137)),
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
                        const Divider(color: Color.fromARGB(255, 137, 137, 137)),
                      ]),
                    ],
                  ),
                ),
              ));
  }
}
