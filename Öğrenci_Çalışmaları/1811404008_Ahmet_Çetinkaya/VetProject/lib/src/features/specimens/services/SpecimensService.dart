import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/genera/models/Genus.dart';
import 'package:vet_project_flutter_frontend/src/features/specimenOwner/models/SpecimenOwner.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/SpecimensListModel.dart';

class SpecimensService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/specimens';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byProtocolNumber}) async {
    var data = await db.collection('specimens').get();
    var genera = (await db.collection('genera').get())
        ?.values
        .map((e) => Genus.fromJson(e))
        .toList();
    var specimenOwners = (await db.collection('specimenOwners').get())
        ?.values
        .map((e) => SpecimenOwner.fromJson(e))
        .toList();
    var model = SpecimenListModel(
        data: data?.values
                .map((e) {
                  var model = Specimen.fromJson(e);
                  model.genus =
                      genera?.firstWhereOrNull((e) => e.id == model.genusId);
                  model.specimenOwner = specimenOwners?.firstWhereOrNull(
                      (element) => element.id == model.ownerId);
                  return model;
                })
                .where((element) =>
                    element.pathologyReportId
                        ?.startsWith(byProtocolNumber ?? "") ??
                    false)
                .skip(page * pageSize)
                .take(pageSize)
                .toList() ??
            [],
        currentPage: page,
        perPage: pageSize);
    return http.Response.bytes(
        utf8.encode(jsonEncode(model.toJson())), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> getById(int id) async {
    var data = await db.collection('specimens').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(Specimen specimen) async {
    final id = ((await db.collection('specimens').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'pathology_report_id': specimen.pathologyReportId,
      'owner_id': specimen.ownerId,
      'genus_id': specimen.genusId,
      'sex': specimen.sex,
      'age': specimen.age,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db.collection('specimens').doc(id.toString()).set(command);

    var data = await db.collection('specimens').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(Specimen specimen) async {
    Map<String, dynamic> command = {
      'id': specimen.id,
      'pathology_report_id': specimen.pathologyReportId,
      'owner_id': specimen.ownerId,
      'genus_id': specimen.genusId,
      'sex': specimen.sex,
      'age': specimen.age,
      'created_at': specimen.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db.collection('specimens').doc(specimen.id.toString()).set(command);
    var data =
        await db.collection('specimens').doc(specimen.id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(Specimen specimen) async {
    var data =
        await db.collection('specimens').doc(specimen.id.toString()).delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
