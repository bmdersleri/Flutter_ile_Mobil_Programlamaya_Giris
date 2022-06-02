import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/models/BacteriologicAnalysis.dart';
import 'package:vet_project_flutter_frontend/src/features/bacteriologicAnalyses/models/BacteriologicAnalysisListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class BacteriologicAnalysesService {
  final String _controllerUrl =
      '${dotenv.env['API_URL']}/bacteriologicAnalyses';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, String? byAnalysisId}) async {
    var data = await db.collection('bacteriologicAnalyses').get();
    var statusTypes = (await db.collection('statusTypes').get())
        ?.values
        .map((e) => StatusType.fromJson(e));
    var users = (await db.collection('users').get())
        ?.values
        .map((e) => User.fromJson(e));
    var model = BacteriologicAnalysisListModel(
        data: data?.values
                .map((e) {
                  var model = BacteriologicAnalysis.fromJson(e);
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
        await db.collection('bacteriologicAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(
      BacteriologicAnalysis bacteriologicAnalysis) async {
    final id =
        ((await db.collection('bacteriologicAnalyses').get())?.length ?? 0) + 1;
    Map<String, dynamic> command = {
      'id': id,
      'analysis_id': bacteriologicAnalysis.analysisId,
      'status_id': bacteriologicAnalysis.statusId,
      'bacteriologic_analysis': bacteriologicAnalysis.bacteriologicAnalysis,
      'assignee_user_id': bacteriologicAnalysis.assigneeUserId,
      'approved_by_user_id': bacteriologicAnalysis.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('bacteriologicAnalyses')
        .doc(id.toString())
        .set(command);

    var data =
        await db.collection('bacteriologicAnalyses').doc(id.toString()).get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(
      BacteriologicAnalysis bacteriologicAnalysis) async {
    Map<String, dynamic> command = {
      'id': bacteriologicAnalysis.id,
      'analysis_id': bacteriologicAnalysis.analysisId,
      'status_id': bacteriologicAnalysis.statusId,
      'bacteriologic_analysis': bacteriologicAnalysis.bacteriologicAnalysis,
      'assignee_user_id': bacteriologicAnalysis.assigneeUserId,
      'approved_by_user_id': bacteriologicAnalysis.approvedByUserId,
      'created_at': bacteriologicAnalysis.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('bacteriologicAnalyses')
        .doc(bacteriologicAnalysis.id.toString())
        .set(command);
    var data = await db
        .collection('bacteriologicAnalyses')
        .doc(bacteriologicAnalysis.id.toString())
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(
      BacteriologicAnalysis bacteriologicAnalysis) async {
    var data = await db
        .collection('bacteriologicAnalyses')
        .doc(bacteriologicAnalysis.id.toString())
        .get();
    data!['approved_by_user_id'] = bacteriologicAnalysis.approvedByUserId;
    await db
        .collection('bacteriologicAnalyses')
        .doc(bacteriologicAnalysis.id.toString())
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(
      BacteriologicAnalysis bacteriologicAnalysis) async {
    var data = await db
        .collection('bacteriologicAnalyses')
        .doc(bacteriologicAnalysis.id.toString())
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}
