import 'package:vet_project_flutter_frontend/src/features/breeds/models/Breed.dart';

class Genus {
  int? id;
  int? breedId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Breed? breed;

  Genus(
      {this.id,
      this.breedId,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.breed});

  Genus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breedId = json['breed_id'];
    name = json['name'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    breed = json['breed'] != null ? Breed.fromJson(json['breed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['breed_id'] = breedId;
    data['name'] = name;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    if (breed != null) {
      data['breed'] = breed!.toJson();
    }
    return data;
  }
}
