import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:vet_project_flutter_frontend/src/features/genera/models/Genus.dart';
import 'package:vet_project_flutter_frontend/src/features/genera/services/GeneraService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/DialogService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/services/ToastService.dart';
import 'package:vet_project_flutter_frontend/src/features/specimenOwner/models/SpecimenOwner.dart';
import 'package:vet_project_flutter_frontend/src/features/specimenOwner/services/SpecimenOwnersService.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Sex.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/services/SpecimensService.dart';

import '../models/Sex.dart';

class SpecimenFormScreenWidget extends StatefulWidget {
  int? specimenIdToUpdate;
  String? pathologyReportIdToAdd;
  final SpecimensService _specimensService = SpecimensService();
  final GeneraService _generaService = GeneraService();
  final SpecimenOwnersService _specimenOwnersService = SpecimenOwnersService();

  SpecimenFormScreenWidget({Key? key, this.specimenIdToUpdate, this.pathologyReportIdToAdd}) : super(key: key);

  @override
  _SpecimenFormScreenWidgetState createState() {
    return _SpecimenFormScreenWidgetState();
  }
}

class _SpecimenFormScreenWidgetState extends State<SpecimenFormScreenWidget> {
  Specimen? _specimen;
  final List<Genus> _genera = [];
  final List<SpecimenOwner> _specimenOwners = [];

  bool _isConfiguredForm = false;
  bool _isEditing = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _configureEditOrCreateForm();
    _getAllGenera();
    _getAllSpecimenOwners();
  }

  void _configureEditOrCreateForm() {
    if (_isConfiguredForm) return;
    _isConfiguredForm = true;

    if (widget.specimenIdToUpdate != null) {
      // Edit
      setState(() {
        _isEditing = true;
        _isLoading = true;
      });

      if (_specimen == null) {
        _getById(widget.specimenIdToUpdate as int);
      }
    } else {
      // Create
      _specimen = Specimen(pathologyReportId: widget.pathologyReportIdToAdd, age: 0, sex: 0);
    }
  }

  Future _getById(int id) async {
    var result = await widget._specimensService.getById(id);
    if (!mounted) return;
    setState(() {
      _specimen = Specimen.fromJson(jsonDecode(result.body));
      _isLoading = false;
    });
  }

  Future _getAllGenera() async {
    var result = await widget._generaService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _genera.addAll(((body['data'] as List).map((data) => Genus.fromJson(jsonDecode(jsonEncode(data))))));
    });
  }

  Future _getAllSpecimenOwners() async {
    var result = await widget._specimenOwnersService.getList(page: 0, pageSize: 999);
    Map<String, dynamic> body = jsonDecode(result.body);
    if (!mounted) return;
    setState(() {
      _specimenOwners.addAll(((body['data'] as List).map((data) => SpecimenOwner.fromJson(jsonDecode(jsonEncode(data))))));
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
    Response result = await widget._specimensService.create(_specimen!);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Numune eklendi.");
    if (!mounted) return;
    setState(() {
      _isEditing = true;
    });
    Map<String, dynamic> body = jsonDecode(result.body);
    await _getById(body["id"] as int);
  }

  Future _update() async {
    Response result = await widget._specimensService.update(_specimen!);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }

    ToastService.showSnackBar(context, "Numune güncellendi.");
    await _getById(_specimen?.id as int);
  }

  Future _delete() async {
    Response result = await widget._specimensService.delete(_specimen!);

    if (result.statusCode != HttpStatus.ok) {
      ToastService.showSnackBar(context, "Bir sorun oluştu.");
      return;
    }
    ToastService.showSnackBar(context, "Numune silindi.");
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
          title: Text('${_specimen?.id != null ? '${_specimen?.id} -' : ''} Numune Kaydı'),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Sil"),
                        enabled: _isEditing,
                        onTap: () => Future.delayed(const Duration(seconds: 0), () => DialogService.showConfirmDialog(context, title: 'Silmek İstediğinize Emin Misiniz?', onConfirm: _delete)),
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
                      DropdownSearch<Genus>(
                        items: _genera,
                        selectedItem: _specimen != null ? _genera.firstWhereOrNull((e) => e.id == _specimen?.genusId) : null,
                        onChanged: (e) => setState(() => _specimen?.genusId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "Hayvan Türü", prefixIcon: Icon(Icons.pets)),
                      ),

                      //# AGE
                      TextFormField(
                        key: Key(_specimen?.id.toString() ?? ''),
                        initialValue: _specimen?.age.toString(),
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        keyboardType: TextInputType.number,
                        onChanged: (value) => setState(() => _specimen?.age = value.isNotEmpty ? int.parse(value) : 0),
                        autofocus: false,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          labelText: "Yaş",
                        ),
                      ),

                      //# SEX
                      DropdownSearch<Sex>(
                        items: sexList,
                        selectedItem: _specimen != null ? sexList.firstWhereOrNull((e) => e.id == _specimen?.sex) : null,
                        onChanged: (e) => setState(() => _specimen?.sex = e?.id),
                        itemAsString: (e) => e?.name as String,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "Cinsiyet", prefixIcon: Icon(Icons.transgender)),
                      ),

                      //# SPECIMEN OWNER
                      DropdownSearch<SpecimenOwner>(
                        items: _specimenOwners,
                        selectedItem: _specimen != null ? _specimenOwners.firstWhereOrNull((e) => e.id == _specimen?.ownerId) : null,
                        onChanged: (e) => setState(() => _specimen?.ownerId = e?.id),
                        itemAsString: (e) => e?.name as String,
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        dropdownSearchDecoration: const InputDecoration(labelText: "Hayvan Sahibi", prefixIcon: Icon(Icons.person)),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
