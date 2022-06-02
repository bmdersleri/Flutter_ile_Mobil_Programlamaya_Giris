import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/models/AnamnesisDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/anamnesisDiagnoses/models/AnamnesisDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class AnamnesisDiagnosesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/anamnesisDiagnoses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byDiagnosisId}) async {
    var data = await db.collection('anamnesisDiagnoses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = AnamnesisDiagnosisListModel(
        data: data?.values
                .map((e) {
                  var model = AnamnesisDiagnosis.fromJson(e);
                  model.status = statusTypes
                      ?.firstWhereOrNull((e) => e.id == model.statusId);
                  model.assigneeUser = users?.firstWhereOrNull(
                      (element) => element.id == model.assigneeUserId);
                  model.approvedByUser = users?.firstWhereOrNull(
                      (element) => element.id == model.approvedByUserId);
                  return model;
                })
                .skip(page * pageSize)
                .take(pageSize)
                .where((element) =>
                    element.diagnosisId?.startsWith(byDiagnosisId ?? "") ??
                    false)
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
    var data =
        await db.collection('anamnesisDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(AnamnesisDiagnosis anamnesisDiagnosis) async {
    final id =
        ((await db.collection('anamnesisDiagnoses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'diagnosis_id': anamnesisDiagnosis.diagnosisId,
      'status_id': anamnesisDiagnosis.statusId,
      'anamnesis_diagnosis': anamnesisDiagnosis.anamnesisDiagnosis,
      'assignee_user_id': anamnesisDiagnosis.assigneeUserId,
      'approved_by_user_id': anamnesisDiagnosis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db.collection('anamnesisDiagnoses').doc(id.toString()).set(command);

    var data =
        await db.collection('anamnesisDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(AnamnesisDiagnosis anamnesisDiagnosis) async {
    Map<String, dynamic> command = {
      'id': anamnesisDiagnosis.id,
      'diagnosis_id': anamnesisDiagnosis.diagnosisId,
      'status_id': anamnesisDiagnosis.statusId,
      'anamnesis_diagnosis': anamnesisDiagnosis.anamnesisDiagnosis,
      'assignee_user_id': anamnesisDiagnosis.assigneeUserId,
      'approved_by_user_id': anamnesisDiagnosis.approvedByUserId,
      'created_at': anamnesisDiagnosis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('anamnesisDiagnoses')
        .doc(anamnesisDiagnosis.id.toString())
        .set(command);
    var data = await db
        .collection('anamnesisDiagnoses')
        .doc(anamnesisDiagnosis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(AnamnesisDiagnosis anamnesisDiagnosis) async {
    var data = await db
        .collection('anamnesisDiagnoses')
        .doc(anamnesisDiagnosis.id.toString())
        .get();
    data!['approved_by_user_id'] = anamnesisDiagnosis.approvedByUserId;
    await db
        .collection('anamnesisDiagnoses')
        .doc(anamnesisDiagnosis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(AnamnesisDiagnosis anamnesisDiagnosis) async {
    var data = await db
        .collection('anamnesisDiagnoses')
        .doc(anamnesisDiagnosis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
