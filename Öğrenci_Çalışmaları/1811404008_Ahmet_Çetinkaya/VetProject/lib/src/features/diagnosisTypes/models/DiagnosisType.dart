import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';

class DiagnosisType implements IJsonable {
  late int id;
  late String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  DiagnosisType(
      {required this.id,
      required this.name,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  DiagnosisType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    return data;
  }
}
