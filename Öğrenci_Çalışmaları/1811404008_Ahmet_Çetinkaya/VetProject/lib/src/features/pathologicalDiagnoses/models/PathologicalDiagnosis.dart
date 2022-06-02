import 'package:vet_project_flutter_frontend/src/features/diagnosisTypes/models/DiagnosisType.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class PathologicalDiagnosis implements IJsonable {
  int? id;
  String? diagnosisId;
  int? statusId;
  int? diagnosisTypeId;
  String? pathologicalDiagnosis;
  int? assigneeUserId;
  int? approvedByUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  StatusType? status;
  DiagnosisType? diagnosisType;
  User? assigneeUser;
  User? approvedByUser;

  PathologicalDiagnosis(
      {this.id,
      this.diagnosisId,
      this.statusId,
      this.diagnosisTypeId,
      this.pathologicalDiagnosis,
      this.assigneeUserId,
      this.approvedByUserId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.status,
      this.diagnosisType,
      this.assigneeUser,
      this.approvedByUser});

  PathologicalDiagnosis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diagnosisId = json['diagnosis_id'];
    statusId = json['status_id'];
    diagnosisTypeId = json['diagnosis_type_id'];
    pathologicalDiagnosis = json['pathological_diagnosis'];
    assigneeUserId = json['assignee_user_id'];
    approvedByUserId = json['approved_by_user_id'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    status =
        json['status'] != null ? StatusType.fromJson(json['status']) : null;
    diagnosisType = json['diagnosis_type'] != null
        ? DiagnosisType.fromJson(json['diagnosis_type'])
        : null;
    assigneeUser = json['assignee_user'] != null
        ? User.fromJson(json['assignee_user'])
        : null;
    approvedByUser = json['approved_by_user'] != null
        ? User.fromJson(json['approved_by_user'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diagnosis_id'] = diagnosisId;
    data['status_id'] = statusId;
    data['diagnosis_type_id'] = diagnosisTypeId;
    data['pathological_diagnosis'] = pathologicalDiagnosis;
    data['assignee_user_id'] = assigneeUserId;
    data['approved_by_user_id'] = approvedByUserId;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (diagnosisType != null) {
      data['diagnosis_type'] = diagnosisType!.toJson();
    }
    if (assigneeUser != null) {
      data['assignee_user'] = assigneeUser!.toJson();
    }
    if (approvedByUser != null) {
      data['approved_by_user'] = approvedByUser!.toJson();
    }
    return data;
  }
}
