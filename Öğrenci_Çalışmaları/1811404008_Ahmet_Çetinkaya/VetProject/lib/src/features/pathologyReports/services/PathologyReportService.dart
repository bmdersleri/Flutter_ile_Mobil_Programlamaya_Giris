import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import "package:http/http.dart" as http;
import 'package:vet_project_flutter_frontend/main.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/models/Analysis.dart';
import 'package:vet_project_flutter_frontend/src/features/analyses/services/AnalysesService.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/models/Diagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/diagnoses/services/DiagnosesService.dart';
import 'package:vet_project_flutter_frontend/src/features/genera/models/Genus.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReport.dart';
import 'package:vet_project_flutter_frontend/src/features/pathologyReports/models/PathologyReportListModel.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';

class PathologyReportService {
  final String _controllerUrl = '${dotenv.env['API_URL']}/pathologyReports';

  Future<http.Response> getList(
      {int page = 0, int pageSize = 10, byProtocolNumber}) async {
    var data = await db.collection('pathologyReports').get();
    var genera = (await db.collection('genera').get())
        ?.values
        .map((e) => Genus.fromJson(e));
    var specimens = (await db.collection('specimens').get())?.values.map((e) {
      var model = Specimen.fromJson(e);
      model.genus = genera?.firstWhereOrNull((e) => e.id == model.genusId);
      return model;
    });
    var model = PathologyReportListModel(
        data: data?.values
                .map((e) {
                  var model = PathologyReport.fromJson(e);
                  model.specimens = specimens
                          ?.where((e) =>
                              e.pathologyReportId == model.protocolNumber)
                          .toList() ??
                      [];
                  return model;
                })
                .skip(page * pageSize)
                .take(pageSize)
                .where((element) =>
                    element.protocolNumber
                        ?.startsWith(byProtocolNumber ?? "") ??
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

  Future<http.Response> getByProtocolNumber(String protocolNumber) async {
    var data = await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(protocolNumber))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> create(PathologyReport pathologyReport) async {
    Map<String, dynamic> command = {
      'protocol_number': pathologyReport.protocolNumber,
      'status_id': pathologyReport.statusId,
      'examination_type_id': pathologyReport.examinationTypeId,
      'report': pathologyReport.report,
      'assignee_user_id': pathologyReport.assigneeUserId,
      'approved_by_user_id': pathologyReport.approvedByUserId,
      'created_at': DateTime.now().toString(),
      'updated_at': null,
    };
    await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .set(command);
    AnalysesService().create(Analysis(
        pathologyReportId: pathologyReport.protocolNumber, statusId: 1));
    DiagnosesService().create(Diagnosis(
        pathologyReportId: pathologyReport.protocolNumber, statusId: 1));
    var totalData = await db.collection('pathologyReports').doc("total").get();
    totalData!['total'] = totalData['total'] + 1;
    await db.collection('pathologyReports').doc("total").set(totalData);

    var data = await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> update(PathologyReport pathologyReport) async {
    Map<String, dynamic> command = {
      'protocol_number': pathologyReport.protocolNumber,
      'status_id': pathologyReport.statusId,
      'examination_type_id': pathologyReport.examinationTypeId,
      'report': pathologyReport.report,
      'assignee_user_id': pathologyReport.assigneeUserId,
      'approved_by_user_id': pathologyReport.approvedByUserId,
      'created_at': pathologyReport.createdAt.toString(),
      'updated_at': DateTime.now().toString(),
    };
    await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .set(command);
    var data = await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .get();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> approve(PathologyReport pathologyReport) async {
    var data = await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .get();
    data!['approved_by_user_id'] = pathologyReport.approvedByUserId;
    await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .set(data);
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> delete(PathologyReport pathologyReport) async {
    var data = await db
        .collection('pathologyReports')
        .doc(convertProtocolNumberToSafe(
            pathologyReport.protocolNumber as String))
        .delete();
    return http.Response.bytes(utf8.encode(jsonEncode(data)), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }

  Future<http.Response> nextOrderInYear() async {
    var total = await db.collection('pathologyReports').doc("total").get();
    return http.Response.bytes(
        utf8.encode(total!['total'].toString()), HttpStatus.ok,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        });
  }
}

String convertProtocolNumberToSafe(String protocolNumber) {
  return protocolNumber.replaceFirst("/", "_");
}

String convertSafeProtocolNumberToNormal(String protocolNumber) {
  return protocolNumber.replaceFirst("_", "/");
}
