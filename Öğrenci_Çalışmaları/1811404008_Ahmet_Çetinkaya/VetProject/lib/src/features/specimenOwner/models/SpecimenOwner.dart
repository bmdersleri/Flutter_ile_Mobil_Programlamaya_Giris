class SpecimenOwner {
  int? id;
  String? name;
  String? phoneNumber;
  int? addressCityId;
  int? addressDistrictId;
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  SpecimenOwner(
      {this.id,
      this.name,
      this.phoneNumber,
      this.addressCityId,
      this.addressDistrictId,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SpecimenOwner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    addressCityId = json['address_city_id'];
    addressDistrictId = json['address_district_id'];
    address = json['address'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['address_city_id'] = addressCityId;
    data['address_district_id'] = addressDistrictId;
    data['address'] = address;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    return data;
  }
}
