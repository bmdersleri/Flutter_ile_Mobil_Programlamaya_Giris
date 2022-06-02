import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnosisTypes/models/DiagnosisType.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/models/PathologicalDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologicalDiagnoses/models/PathologicalDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class PathologicalDiagnosesService {
  final String _controllerUrl =
      '${dotenv.env['API_URL']}/pathologicalDiagnoses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byDiagnosisId}) async {
    var data = await db.collection('pathologicalDiagnoses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var diagnosisTypes = (await db.collection('diagnosisTypes').get())
        ?.values
        .map((e) => DiagnosisType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = PathologicalDiagnosisListModel(
        data: data?.values
                .map((e) {
                  var model = PathologicalDiagnosis.fromJson(e);
                  model.status = statusTypes
                      ?.firstWhereOrNull((e) => e.id == model.statusId);
                  model.diagnosisType = diagnosisTypes?.firstWhereOrNull(
                      (element) => element.id == model.diagnosisTypeId);
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
        await db.collection('pathologicalDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      PathologicalDiagnosis pathologicalDiagnosis) async {
    final id =
        ((await db.collection('pathologicalDiagnoses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'diagnosis_id': pathologicalDiagnosis.diagnosisId,
      'diagnosis_type_id': pathologicalDiagnosis.diagnosisTypeId,
      'status_id': pathologicalDiagnosis.statusId,
      'pathological_diagnosis': pathologicalDiagnosis.pathologicalDiagnosis,
      'assignee_user_id': pathologicalDiagnosis.assigneeUserId,
      'approved_by_user_id': pathologicalDiagnosis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('pathologicalDiagnoses')
        .doc(id.toString())
        .set(command);

    var data =
        await db.collection('pathologicalDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(
      PathologicalDiagnosis pathologicalDiagnosis) async {
    Map<String, dynamic> command = {
      'id': pathologicalDiagnosis.id,
      'diagnosis_id': pathologicalDiagnosis.diagnosisId,
      'status_id': pathologicalDiagnosis.statusId,
      'diagnosis_type_id': pathologicalDiagnosis.diagnosisTypeId,
      'pathological_diagnosis': pathologicalDiagnosis.pathologicalDiagnosis,
      'assignee_user_id': pathologicalDiagnosis.assigneeUserId,
      'approved_by_user_id': pathologicalDiagnosis.approvedByUserId,
      'created_at': pathologicalDiagnosis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('pathologicalDiagnoses')
        .doc(pathologicalDiagnosis.id.toString())
        .set(command);
    var data = await db
        .collection('pathologicalDiagnoses')
        .doc(pathologicalDiagnosis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      PathologicalDiagnosis pathologicalDiagnosis) async {
    var data = await db
        .collection('pathologicalDiagnoses')
        .doc(pathologicalDiagnosis.id.toString())
        .get();
    data!['approved_by_user_id'] = pathologicalDiagnosis.approvedByUserId;
    await db
        .collection('pathologicalDiagnoses')
        .doc(pathologicalDiagnosis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      PathologicalDiagnosis pathologicalDiagnosis) async {
    var data = await db
        .collection('pathologicalDiagnoses')
        .doc(pathologicalDiagnosis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
