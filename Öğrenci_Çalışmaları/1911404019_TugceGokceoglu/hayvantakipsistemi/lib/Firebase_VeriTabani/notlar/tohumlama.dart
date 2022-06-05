import 'package:cloud_firestore/cloud_firestore.dart';

class TohumlamaEkleFirebase {
  final String hayvanId;
  final String tohumlamaId;
  final String hayvaninkupeno;
  final String boganinkupeno;
  final String boganinirki;
  final String tohumlamayiyapanvet;
  final String tohumlamanot;
  final DateTime tohumlamabaslangic;
  final DateTime tohumlamabitis;

  TohumlamaEkleFirebase({
    required this.boganinkupeno,
    required this.tohumlamayiyapanvet,
    required this.tohumlamanot,
    required this.hayvanId,
    required this.tohumlamaId,
    required this.hayvaninkupeno,
    required this.boganinirki,
    required this.tohumlamabaslangic,
    required this.tohumlamabitis,
  });
  Map<String, dynamic> toJson() => {
        //Mape Dönüştür
        'hayvanId': hayvanId,
        'tohumlamayiyapanvet': tohumlamayiyapanvet,
        'tohumlamanot': tohumlamanot,
        'tohumlamaId':tohumlamaId,
        'boganinkupeno':boganinkupeno,
        'hayvaninkupeno': hayvaninkupeno,
        'boganinirki':boganinirki,
        'tohumlamabaslangic':tohumlamabaslangic,
        'tohumlamabitis':tohumlamabitis,
      };

  static TohumlamaEkleFirebase fromJson(Map<String, dynamic> json) => //Mapten oluştur
      TohumlamaEkleFirebase(
        boganinkupeno: json['boganinkupeno'],
        tohumlamayiyapanvet: json['tohumlamayiyapanvet'],
        tohumlamanot: json['tohumlamanot'],
        hayvanId: json['hayvanId'],
        tohumlamaId: json['tohumlamaId'],
        hayvaninkupeno: json['hayvaninkupeno'],
        boganinirki: json['boganinirki'],
        tohumlamabaslangic:(json['tohumlamabaslangic'] as Timestamp).toDate(),
        tohumlamabitis:(json['tohumlamabitis'] as Timestamp).toDate(),
      );
}