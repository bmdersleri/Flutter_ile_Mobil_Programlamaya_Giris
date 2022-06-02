import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';

class ExaminationType implements IJsonable {
  late int id;
  late String name;
  late DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  ExaminationType(
      {required this.id,
      required this.name,
      required this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ExaminationType.fromJson(Map<String, dynamic> json) {
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
