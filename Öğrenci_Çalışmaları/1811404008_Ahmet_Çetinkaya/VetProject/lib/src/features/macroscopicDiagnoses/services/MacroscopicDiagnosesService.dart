import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/services/PathologyReportService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class MacroscopicDiagnosesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/macroscopicDiagnoses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byDiagnosisId}) async {
    var data = await db.collection('macroscopicDiagnoses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e))
        .toList();
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e))
        .toList();
    var model = MacroscopicDiagnosisListModel(
        data: data?.values
                .map((e) {
                  var model = MacroscopicDiagnosis.fromJson(e);
                  model.status = statusTypes
                      ?.firstWhereOrNull((e) => e.id == model.statusId);
                  model.assigneeUser = users?.firstWhereOrNull(
                      (element) => element.id == model.assigneeUserId);
                  model.approvedByUser = users?.firstWhereOrNull(
                      (element) => element.id == model.approvedByUserId);
                  return model;
                })
                .where((element) =>
                    element.diagnosisId?.startsWith(byDiagnosisId ?? "") ??
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

  Future<http.Response> getAllFiles(int id) async {
    var data =
        await db.collection('macroscopicDiagnoses').doc(id.toString()).get();
    var model = MacroscopicDiagnosis.fromJson(data!);
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_PICTURES);
    var folder =
        "$path/vetProject/${convertProtocolNumberToSafe(model.diagnosisId ?? "")}/macroscopic/$id";
    var files = Directory(folder).existsSync()
        ? Directory(folder).listSync().map((e) => e.path).toList()
        : [];
    return http.Response.bytes(utf8.encode(jsonEncode(files)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> getById(int id) async {
    var data =
        await db.collection('macroscopicDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      MacroscopicDiagnosis macroscopicDiagnosis) async {
    final id =
        ((await db.collection('macroscopicDiagnoses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'diagnosis_id': macroscopicDiagnosis.diagnosisId,
      'status_id': macroscopicDiagnosis.statusId,
      'macroscopic_diagnosis': macroscopicDiagnosis.macroscopicDiagnosis,
      'assignee_user_id': macroscopicDiagnosis.assigneeUserId,
      'approved_by_user_id': macroscopicDiagnosis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db.collection('macroscopicDiagnoses').doc(id.toString()).set(command);

    var data =
        await db.collection('macroscopicDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.BaseResponse> uploadFile(
      MacroscopicDiagnosis macroscopicDiagnosis, XFile file) async {
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_PICTURES);
    var folder =
        "$path/vetProject/${convertProtocolNumberToSafe(macroscopicDiagnosis.diagnosisId ?? "")}/macroscopic/${macroscopicDiagnosis.id}";
    await Directory(folder).create(recursive: true);
    await file.saveTo("$folder/${file.name}");
    return http.Response.bytes(utf8.encode("true"), HttpStatus.ok, headers: {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    });
  }

  Future<http.BaseResponse> deleteFile(String filePath) async {
    return await http
        .delete(Uri.parse('$_controllerUrl/deleteFile?path=$filePath'));
  }

  Future<http.Response> update(
      MacroscopicDiagnosis macroscopicDiagnosis) async {
    Map<String, dynamic> command = {
      'id': macroscopicDiagnosis.id,
      'diagnosis_id': macroscopicDiagnosis.diagnosisId,
      'status_id': macroscopicDiagnosis.statusId,
      'macroscopic_diagnosis': macroscopicDiagnosis.macroscopicDiagnosis,
      'assignee_user_id': macroscopicDiagnosis.assigneeUserId,
      'approved_by_user_id': macroscopicDiagnosis.approvedByUserId,
      'created_at': macroscopicDiagnosis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('macroscopicDiagnoses')
        .doc(macroscopicDiagnosis.id.toString())
        .set(command);
    var data = await db
        .collection('macroscopicDiagnoses')
        .doc(macroscopicDiagnosis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      MacroscopicDiagnosis macroscopicDiagnosis) async {
    var data = await db
        .collection('macroscopicDiagnoses')
        .doc(macroscopicDiagnosis.id.toString())
        .get();
    data!['approved_by_user_id'] = macroscopicDiagnosis.approvedByUserId;
    await db
        .collection('macroscopicDiagnoses')
        .doc(macroscopicDiagnosis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      MacroscopicDiagnosis macroscopicDiagnosis) async {
    var data = await db
        .collection('macroscopicDiagnoses')
        .doc(macroscopicDiagnosis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
