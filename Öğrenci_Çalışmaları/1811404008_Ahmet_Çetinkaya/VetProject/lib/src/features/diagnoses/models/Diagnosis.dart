import 'package:vet_project_flutter_frontend/src/features/macroscopicDiagnoses/models/MacroscopicDiagnosis.dart';

class Diagnosis {
  String? pathologyReportId;
  int? diseaseTypeId;
  int? statusId;
  int? assigneeUserId;
  int? approvedByUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<MacroscopicDiagnosis>? macroscopicDiagnoses;

  Diagnosis(
      {this.pathologyReportId,
      this.diseaseTypeId,
      this.statusId,
      this.assigneeUserId,
      this.approvedByUserId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.macroscopicDiagnoses});

  Diagnosis.fromJson(Map<String, dynamic> json) {
    pathologyReportId = json['pathology_report_id'];
    diseaseTypeId = json['disease_type_id'];
    statusId = json['status_id'];
    assigneeUserId = json['assignee_user_id'];
    approvedByUserId = json['approved_by_user_id'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    if (json['macroscopic_diagnoses'] != null) {
      macroscopicDiagnoses = <MacroscopicDiagnosis>[];
      json['macroscopic_diagnoses'].forEach((v) {
        macroscopicDiagnoses!.add(MacroscopicDiagnosis.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pathology_report_id'] = pathologyReportId;
    data['disease_type_id'] = diseaseTypeId;
    data['status_id'] = statusId;
    data['assignee_user_id'] = assigneeUserId;
    data['approved_by_user_id'] = approvedByUserId;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    if (macroscopicDiagnoses != null) {
      data['macroscopic_diagnoses'] =
          macroscopicDiagnoses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
