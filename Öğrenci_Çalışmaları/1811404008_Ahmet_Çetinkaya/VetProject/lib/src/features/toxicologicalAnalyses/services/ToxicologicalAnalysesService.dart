import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/models/ToxicologicalAnalysis.dart';
import 'package:vet_project_flutter_frontend/src/features/toxicologicalAnalyses/models/ToxicologicalAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class ToxicologicalAnalysesService {
  final String _controllerUrl =
      '${dotenv.env['API_URL']}/toxicologicalAnalyses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byAnalysisId}) async {
    var data = await db.collection('toxicologicalAnalyses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = ToxicologicalAnalysisListModel(
        data: data?.values
                .map((e) {
                  var model = ToxicologicalAnalysis.fromJson(e);
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
        await db.collection('toxicologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      ToxicologicalAnalysis toxicologicalAnalysis) async {
    final id =
        ((await db.collection('toxicologicalAnalyses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'analysis_id': toxicologicalAnalysis.analysisId,
      'status_id': toxicologicalAnalysis.statusId,
      'toxicological_analysis': toxicologicalAnalysis.toxicologicalAnalysis,
      'assignee_user_id': toxicologicalAnalysis.assigneeUserId,
      'approved_by_user_id': toxicologicalAnalysis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('toxicologicalAnalyses')
        .doc(id.toString())
        .set(command);

    var data =
        await db.collection('toxicologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(
      ToxicologicalAnalysis toxicologicalAnalysis) async {
    Map<String, dynamic> command = {
      'id': toxicologicalAnalysis.id,
      'analysis_id': toxicologicalAnalysis.analysisId,
      'status_id': toxicologicalAnalysis.statusId,
      'toxicological_analysis': toxicologicalAnalysis.toxicologicalAnalysis,
      'assignee_user_id': toxicologicalAnalysis.assigneeUserId,
      'approved_by_user_id': toxicologicalAnalysis.approvedByUserId,
      'created_at': toxicologicalAnalysis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('toxicologicalAnalyses')
        .doc(toxicologicalAnalysis.id.toString())
        .set(command);
    var data = await db
        .collection('toxicologicalAnalyses')
        .doc(toxicologicalAnalysis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      ToxicologicalAnalysis toxicologicalAnalysis) async {
    var data = await db
        .collection('toxicologicalAnalyses')
        .doc(toxicologicalAnalysis.id.toString())
        .get();
    data!['approved_by_user_id'] = toxicologicalAnalysis.approvedByUserId;
    await db
        .collection('toxicologicalAnalyses')
        .doc(toxicologicalAnalysis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      ToxicologicalAnalysis toxicologicalAnalysis) async {
    var data = await db
        .collection('toxicologicalAnalyses')
        .doc(toxicologicalAnalysis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
