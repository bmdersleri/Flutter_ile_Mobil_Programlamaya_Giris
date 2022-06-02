import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/models/MicroscopicDiagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/microscopicDiagnoses/models/MicroscopicDiagnosisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/services/PathologyReportService.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class MicroscopicDiagnosesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/microscopicDiagnoses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byDiagnosisId}) async {
    var data = await db.collection('microscopicDiagnoses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e))
        .toList();
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e))
        .toList();
    var model = MicroscopicDiagnosisListModel(
        data: data?.values
                .map((e) {
                  var model = MicroscopicDiagnosis.fromJson(e);
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
        await db.collection('microscopicDiagnoses').doc(id.toString()).get();
    var model = MicroscopicDiagnosis.fromJson(data!);
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_PICTURES);
    var folder =
        "$path/vetProject/${convertProtocolNumberToSafe(model.diagnosisId ?? "")}/microscopic/$id";
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
        await db.collection('microscopicDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      MicroscopicDiagnosis microscopicDiagnosis) async {
    final id =
        ((await db.collection('macroscopicDiagnoses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'diagnosis_id': microscopicDiagnosis.diagnosisId,
      'status_id': microscopicDiagnosis.statusId,
      'macroscopic_diagnosis': microscopicDiagnosis.microscopicDiagnosis,
      'assignee_user_id': microscopicDiagnosis.assigneeUserId,
      'approved_by_user_id': microscopicDiagnosis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db.collection('microscopicDiagnoses').doc(id.toString()).set(command);

    var data =
        await db.collection('microscopicDiagnoses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.BaseResponse> uploadFile(
      MicroscopicDiagnosis microscopicDiagnosis, XFile file) async {
    var path = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_PICTURES);
    var folder =
        "$path/vetProject/${convertProtocolNumberToSafe(microscopicDiagnosis.diagnosisId ?? "")}/microscopic/${microscopicDiagnosis.id}";
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
      MicroscopicDiagnosis microscopicDiagnosis) async {
    Map<String, dynamic> command = {
      'id': microscopicDiagnosis.id,
      'diagnosis_id': microscopicDiagnosis.diagnosisId,
      'status_id': microscopicDiagnosis.statusId,
      'macroscopic_diagnosis': microscopicDiagnosis.microscopicDiagnosis,
      'assignee_user_id': microscopicDiagnosis.assigneeUserId,
      'approved_by_user_id': microscopicDiagnosis.approvedByUserId,
      'created_at': microscopicDiagnosis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('microscopicDiagnoses')
        .doc(microscopicDiagnosis.id.toString())
        .set(command);
    var data = await db
        .collection('microscopicDiagnoses')
        .doc(microscopicDiagnosis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      MicroscopicDiagnosis microscopicDiagnosis) async {
    var data = await db
        .collection('microscopicDiagnoses')
        .doc(microscopicDiagnosis.id.toString())
        .get();
    data!['approved_by_user_id'] = microscopicDiagnosis.approvedByUserId;
    await db
        .collection('microscopicDiagnoses')
        .doc(microscopicDiagnosis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      MicroscopicDiagnosis microscopicDiagnosis) async {
    var data = await db
        .collection('microscopicDiagnoses')
        .doc(microscopicDiagnosis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
