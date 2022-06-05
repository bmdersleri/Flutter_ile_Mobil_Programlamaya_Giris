import 'package:cloud_firestore/cloud_firestore.dart';

class KullaniciFirebase{
  final String id;
  final String name;
  final String email;

  KullaniciFirebase({
    required this.id,
    required this.name,
    required this.email,

  });

  Map<String,dynamic> toJson() =>{ //Mape Dönüştür
    'id':id,
    'name':name,
    'email':email,
  };

  static KullaniciFirebase fromJson(Map<String,dynamic> json)=> //Mapten oluştur
  KullaniciFirebase(
    id:json['id'],
    name: json['name'],
    email: json['email'],
  );
}