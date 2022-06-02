class Breed {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  Breed({this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  Breed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
  }

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
