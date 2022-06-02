import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/models/ParasitologicalAnalysis.dart';
import 'package:vet_project_flutter_frontend/src/features/parasitologicalAnalyses/models/ParasitologicalAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class ParasitologicalAnalysesService {
  final String _controllerUrl =
      '${dotenv.env['API_URL']}/parasitologicalAnalyses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byAnalysisId}) async {
    var data = await db.collection('parasitologicalAnalyses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = ParasitologicalAnalysisListModel(
        data: data?.values
                .map((e) {
                  var model = ParasitologicalAnalysis.fromJson(e);
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
                    element.analysisId?.startsWith(byAnalysisId ?? "") ?? false)
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
        await db.collection('parasitologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      ParasitologicalAnalysis parasitologicalAnalysis) async {
    final id =
        ((await db.collection('parasitologicalAnalyses').get())?.length ?? 0) +
            1;
    Map<String, dynamic> command = {
      'id': id,
      'analysis_id': parasitologicalAnalysis.analysisId,
      'status_id': parasitologicalAnalysis.statusId,
      'parasitological_analysis':
          parasitologicalAnalysis.parasitologicalAnalysis,
      'assignee_user_id': parasitologicalAnalysis.assigneeUserId,
      'approved_by_user_id': parasitologicalAnalysis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('parasitologicalAnalyses')
        .doc(id.toString())
        .set(command);

    var data =
        await db.collection('parasitologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(
      ParasitologicalAnalysis parasitologicalAnalysis) async {
    Map<String, dynamic> command = {
      'id': parasitologicalAnalysis.id,
      'analysis_id': parasitologicalAnalysis.analysisId,
      'status_id': parasitologicalAnalysis.statusId,
      'parasitological_analysis':
          parasitologicalAnalysis.parasitologicalAnalysis,
      'assignee_user_id': parasitologicalAnalysis.assigneeUserId,
      'approved_by_user_id': parasitologicalAnalysis.approvedByUserId,
      'created_at': parasitologicalAnalysis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('parasitologicalAnalyses')
        .doc(parasitologicalAnalysis.id.toString())
        .set(command);
    var data = await db
        .collection('parasitologicalAnalyses')
        .doc(parasitologicalAnalysis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      ParasitologicalAnalysis parasitologicalAnalysis) async {
    var data = await db
        .collection('parasitologicalAnalyses')
        .doc(parasitologicalAnalysis.id.toString())
        .get();
    data!['approved_by_user_id'] = parasitologicalAnalysis.approvedByUserId;
    await db
        .collection('parasitologicalAnalyses')
        .doc(parasitologicalAnalysis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      ParasitologicalAnalysis parasitologicalAnalysis) async {
    var data = await db
        .collection('parasitologicalAnalyses')
        .doc(parasitologicalAnalysis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
