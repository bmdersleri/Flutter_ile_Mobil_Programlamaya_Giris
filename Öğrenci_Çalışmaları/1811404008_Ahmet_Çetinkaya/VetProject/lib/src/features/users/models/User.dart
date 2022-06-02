import 'package:vet_project_flutter_frontend/src/features/shared/models/IJsonable.dart';

class User implements IJsonable {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? emailVerifiedAt;
  String? password;
  String? profileImagePath;
  String? rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.profileImagePath,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    profileImagePath = json['profile_image_path'];
    rememberToken = json['remember_token'];
    createdAt = DateTime.tryParse(json['created_at'] ?? '');
    updatedAt = DateTime.tryParse(json['updated_at'] ?? '');
    deletedAt = DateTime.tryParse(json['deleted_at'] ?? '');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['profile_image_path'] = profileImagePath;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    data['deleted_at'] = deletedAt.toString();
    return data;
  }
}
