import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/models/Diagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/services/PathologyReportService.dart';

class DiagnosesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/diagnoses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byProtocolNumber}) async {
    return http.get(Uri.parse(
        '$_controllerUrl?page=$page&pageSize=$pageSize&like[0]=${byProtocolNumber != null ? "pathology_report_id,$byProtocolNumber" : null}'));
  }

  Future<http.Response> getById(String id) async {
    var data = await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(id))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(Diagnosis diagnosis) async {
    Map<String, dynamic> command = {
      'pathology_report_id': diagnosis.pathologyReportId,
      'disease_type_id': diagnosis.diseaseTypeId,
      'status_id': diagnosis.statusId,
      'assignee_user_id': diagnosis.assigneeUserId,
      'approved_by_user_id': diagnosis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .set(command);
    var data = await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(Diagnosis diagnosis) async {
    Map<String, dynamic> command = {
      'pathology_report_id': diagnosis.pathologyReportId,
      'disease_type_id': diagnosis.diseaseTypeId,
      'status_id': diagnosis.statusId,
      'assignee_user_id': diagnosis.assigneeUserId,
      'approved_by_user_id': diagnosis.approvedByUserId,
      'created_at': diagnosis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .set(command);
    var data = await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(Diagnosis diagnosis) async {
    var data = await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(Diagnosis diagnosis) async {
    var data = await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .get();
    data!['approved_by_user_id'] = diagnosis.approvedByUserId;
    await db
        .collection('diagnoses')
        .doc(convertProtocolNumberToSafe(diagnosis.pathologyReportId as String))
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
