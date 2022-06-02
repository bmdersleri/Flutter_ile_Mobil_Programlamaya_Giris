import 'package:vet_project_flutter_frontend/src/features/genera/models/Genus.dart';
import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';
import 'package:vet_project_flutter_frontend/src/features/specimenOwner/models/SpecimenOwner.dart';

class Specimen implements IJsonable {
  int? id;
  String? pathologyReportId;
  int? ownerId;
  int? genusId;
  int? sex;
  int? age;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Genus? genus;
  SpecimenOwner? specimenOwner;

  Specimen(
      {this.id,
      this.pathologyReportId,
      this.ownerId,
      this.genusId,
      this.sex,
      this.age,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.genus,
      this.specimenOwner});

  Specimen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pathologyReportId = json['pathology_report_id'];
    ownerId = json['owner_id'];
    genusId = json['genus_id'];
    sex = json['sex'];
    age = json['age'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
    genus = json['genus'] != null ? Genus.fromJson(json['genus']) : null;
    specimenOwner =
        json['owner'] != null ? SpecimenOwner.fromJson(json['owner']) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['pathology_report_id'] = pathologyReportId;
    data['owner_id'] = ownerId;
    data['genus_id'] = genusId;
    data['sex'] = sex;
    data['age'] = age;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    if (genus != null) {
      data['genus'] = genus!.toJson();
    }
    if (specimenOwner != null) {
      data['owner'] = specimenOwner!.toJson();
    }
    return data;
  }
}
