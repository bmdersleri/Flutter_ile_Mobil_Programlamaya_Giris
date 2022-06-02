// ignore_for_file: unnecessary_this

import 'package:vet_project_flutter_frontend/src/features/diagnoses/models/Diagnosis.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';
import 'package:vet_project_flutter_frontend/src/features/specimens/models/Specimen.dart';

import '../../examinationTypes/models/ExaminationType.dart';
import '../../statusTypes/models/StatusType.dart';
import '../../users/models/User.dart';

class PathologyReport implements IJsonable {
  String? protocolNumber;
  int? statusId;
  int? examinationTypeId;
  String? report;
  int? assigneeUserId;
  int? approvedByUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  StatusType? status;
  ExaminationType? examinationType;
  User? assigneeUser;
  User? approvedByUser;
  List<Specimen>? specimens;
  List<Diagnosis>? diagnoses;

  PathologyReport(
      {this.protocolNumber,
      this.statusId,
      this.examinationTypeId,
      this.report,
      this.assigneeUserId,
      this.approvedByUserId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.status,
      this.examinationType,
      this.assigneeUser,
      this.approvedByUser,
      this.specimens,
      this.diagnoses});

  PathologyReport.fromJson(Map<String, dynamic> json) {
    protocolNumber = json['protocol_number'];
    statusId = json['status_id'];
    examinationTypeId = json['examination_type_id'];
    report = json['report'];
    assigneeUserId = json['assignee_user_id'];
    approvedByUserId = json['approved_by_user_id'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    status =
        json['status'] != null ? StatusType.fromJson(json['status']) : null;
    examinationType = json['examination_type'] != null
        ? ExaminationType.fromJson(json['examination_type'])
        : null;
    assigneeUser = json['assignee_user'] != null
        ? User.fromJson(json['assignee_user'])
        : null;
    approvedByUser = json['approved_by_user'] != null
        ? User.fromJson(json['approved_by_user'])
        : null;
    if (json['specimens'] != null) {
      specimens = <Specimen>[];
      json['specimens'].forEach((v) {
        specimens!.add(Specimen.fromJson(v));
      });
    }
    if (json['diagnoses'] != null) {
      diagnoses = <Diagnosis>[];
      json['diagnoses'].forEach((v) {
        diagnoses!.add(Diagnosis.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['protocol_number'] = this.protocolNumber;
    data['status_id'] = this.statusId;
    data['examination_type_id'] = this.examinationTypeId;
    data['report'] = this.report;
    data['assignee_user_id'] = this.assigneeUserId;
    data['approved_by_user_id'] = this.approvedByUserId;
    data['created_at'] = this.createdAt.toString();
    data['updated_at'] = this.updatedAt.toString();
    data['deleted_at'] = this.deletedAt.toString();
    if (this.status != null) {
      data['status'] = this.status!.toJson();
    }
    if (this.examinationType != null) {
      data['examination_type'] = this.examinationType!.toJson();
    }
    if (this.assigneeUser != null) {
      data['assignee_user'] = this.assigneeUser!.toJson();
    }
    if (this.approvedByUser != null) {
      data['approved_by_user'] = this.approvedByUser!.toJson();
    }
    if (this.diagnoses != null) {
      data['diagnoses'] = this.diagnoses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
