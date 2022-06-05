import 'package:cloud_firestore/cloud_firestore.dart';

class HayvanEkleFirebase {
  final String kullaniciId;
  final String hayvanId;
  final String hayvanincinsiyeti;
  final String hayvaninkupeno;
  final String hayvaninirki;
  final String anneninirki;
  final String anneninkupeno;
  final String babaninirki;
  final String babaninkupeno;
  final String bulunuduguil;
  final String bulunduguilce;
  final DateTime dogumtarihi;
  final String dogumturu;
  String? resim;

  HayvanEkleFirebase({
    required this.kullaniciId,
    required this.hayvanId,
    required this.hayvanincinsiyeti,
    required this.hayvaninkupeno,
    required this.hayvaninirki,
    required this.anneninkupeno,
    required this.anneninirki,
    required this.babaninkupeno,
    required this.babaninirki,
    required this.bulunuduguil,
    required this.bulunduguilce,
    required this.dogumtarihi,
    required this.dogumturu,
    this.resim,
  });
  Map<String, dynamic> toJson() => {
        //Mape Dönüştür
        'kullaniciId': kullaniciId,
        'hayvanId':hayvanId,
        'hayvanincinsiyeti': hayvanincinsiyeti,
        'hayvaninkupeno': hayvaninkupeno,
        'hayvaninirki': hayvaninirki,
        'anneninkupeno': anneninkupeno,
        'anneninirki': anneninirki,
        'babaninkupeno': babaninkupeno,
        'babaninirki': babaninirki,
        'bulunuduguil': bulunuduguil,
        'bulunduguilce': bulunduguilce,
        'dogumtarihi': dogumtarihi,
        'dogumturu': dogumturu,
        'resim': this.resim,
      };

  static HayvanEkleFirebase fromJson(
          Map<String, dynamic> json) => //Mapten oluştur
      HayvanEkleFirebase(
        kullaniciId: json['kullaniciId'],
        hayvanId: json['hayvanId'],
        hayvanincinsiyeti: json['hayvanincinsiyeti'],
        hayvaninkupeno: json['hayvaninkupeno'],
        hayvaninirki: json['hayvaninirki'],
        anneninkupeno: json['anneninkupeno'],
        anneninirki: json['anneninirki'],
        babaninkupeno: json['babaninkupeno'],
        babaninirki: json['babaninirki'],
        bulunuduguil: json['bulunuduguil'],
        bulunduguilce: json['bulunduguilce'],
        dogumtarihi:(json['dogumtarihi'] as Timestamp).toDate(),
        dogumturu: json['dogumturu'],
        resim: json['resim'],
      );
}
