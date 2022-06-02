import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/models/VirologicalAnalysis.dart';
import 'package:vet_project_flutter_frontend/src/features/virologicalAnalyses/models/VirologicalAnalysisListModel.dart';

class VirologicalAnalysesService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/virologicalAnalyses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byAnalysisId}) async {
    var data = await db.collection('virologicalAnalyses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = VirologicalAnalysisListModel(
        data: data?.values
                .map((e) {
                  var model = VirologicalAnalysis.fromJson(e);
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
        await db.collection('virologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(VirologicalAnalysis virologicalAnalysis) async {
    final id =
        ((await db.collection('toxicologicalAnalyses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'analysis_id': virologicalAnalysis.analysisId,
      'status_id': virologicalAnalysis.statusId,
      'virological_analysis': virologicalAnalysis.virologicalAnalysis,
      'assignee_user_id': virologicalAnalysis.assigneeUserId,
      'approved_by_user_id': virologicalAnalysis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db.collection('virologicalAnalyses').doc(id.toString()).set(command);

    var data =
        await db.collection('virologicalAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(VirologicalAnalysis virologicalAnalysis) async {
    Map<String, dynamic> command = {
      'id': virologicalAnalysis.id,
      'analysis_id': virologicalAnalysis.analysisId,
      'status_id': virologicalAnalysis.statusId,
      'virological_analysis': virologicalAnalysis.virologicalAnalysis,
      'assignee_user_id': virologicalAnalysis.assigneeUserId,
      'approved_by_user_id': virologicalAnalysis.approvedByUserId,
      'created_at': virologicalAnalysis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('virologicalAnalyses')
        .doc(virologicalAnalysis.id.toString())
        .set(command);
    var data = await db
        .collection('virologicalAnalyses')
        .doc(virologicalAnalysis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(VirologicalAnalysis virologicalAnalysis) async {
    var data = await db
        .collection('virologicalAnalyses')
        .doc(virologicalAnalysis.id.toString())
        .get();
    data!['approved_by_user_id'] = virologicalAnalysis.approvedByUserId;
    await db
        .collection('virologicalAnalyses')
        .doc(virologicalAnalysis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(VirologicalAnalysis virologicalAnalysis) async {
    var data = await db
        .collection('virologicalAnalyses')
        .doc(virologicalAnalysis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
