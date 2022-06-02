import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';
import 'package:vet_project_flutter_frontend/src/features/statusTypes/models/StatusType.dart';
import 'package:vet_project_flutter_frontend/src/features/users/models/User.dart';

class ToxicologicalAnalysis implements IJsonable {
  int? id;
  String? analysisId;
  int? statusId;
  String? toxicologicalAnalysis;
  int? assigneeUserId;
  int? approvedByUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  StatusType? status;
  User? assigneeUser;
  User? approvedByUser;

  ToxicologicalAnalysis(
      {this.id,
      this.analysisId,
      this.statusId,
      this.toxicologicalAnalysis,
      this.assigneeUserId,
      this.approvedByUserId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.status,
      this.assigneeUser,
      this.approvedByUser});

  ToxicologicalAnalysis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    analysisId = json['analysis_id'];
    statusId = json['status_id'];
    toxicologicalAnalysis = json['toxicological_analysis'];
    assigneeUserId = json['assignee_user_id'];
    approvedByUserId = json['approved_by_user_id'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    status =
        json['status'] != null ? StatusType.fromJson(json['status']) : null;
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
    data['analysis_id'] = analysisId;
    data['status_id'] = statusId;
    data['toxicological_analysis'] = toxicologicalAnalysis;
    data['assignee_user_id'] = assigneeUserId;
    data['approved_by_user_id'] = approvedByUserId;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    if (status != null) {
      data['status'] = status!.toJson();
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
