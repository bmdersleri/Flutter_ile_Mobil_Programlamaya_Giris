import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/models/Analysis.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/services/PathologyReportService.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/constants/ServiceHttpProperty.dart';

class AnalysesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/analyses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byProtocolNumber}) async {
    return http.get(
        Uri.parse(
            '$_controllerUrl?page=$page&pageSize=$pageSize&like[0]=${byProtocolNumber != null ? "pathology_report_id,$byProtocolNumber" : null}'),
        headers: ServiceHttpProperty.utf8Headers);
  }

  Future<http.Response> getById(String id) async {
    var data = await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(id))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(Analysis analysis) async {
    Map<String, dynamic> command = {
      'pathology_report_id': analysis.pathologyReportId,
      'status_id': analysis.statusId,
      'assignee_user_id': analysis.assigneeUserId,
      'approved_by_user_id': analysis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .set(command);
    var data = await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(Analysis analysis) async {
    Map<String, dynamic> command = {
      'pathology_report_id': analysis.pathologyReportId,
      'status_id': analysis.statusId,
      'assignee_user_id': analysis.assigneeUserId,
      'approved_by_user_id': analysis.approvedByUserId,
      'created_at': analysis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .set(command);
    var data = await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(Analysis analysis) async {
    var data = await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(Analysis analysis) async {
    var data = await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .get();
    data!['approved_by_user_id'] = analysis.approvedByUserId;
    await db
        .collection('analyses')
        .doc(convertProtocolNumberToSafe(analysis.pathologyReportId as String))
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
