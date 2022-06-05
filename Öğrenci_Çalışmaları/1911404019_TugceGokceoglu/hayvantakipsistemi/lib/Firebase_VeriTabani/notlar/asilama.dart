import 'package:cloud_firestore/cloud_firestore.dart';

class AsilamaEkleFirebase {
  final String hayvanId;
  final String asilamaId;
  final String hayvaninkupeno;
  final String yapilanasiismi;
  final String asilayankisiismi;
  final String asilamanot;
  final DateTime asilamabaslangic;
  final DateTime asilamabitis;

  AsilamaEkleFirebase({
    required this.asilamanot,
    required this.asilayankisiismi,
    required this.hayvanId,
    required this.asilamaId,
    required this.hayvaninkupeno,
    required this.yapilanasiismi,
    required this.asilamabaslangic,
    required this.asilamabitis,
  });
  Map<String, dynamic> toJson() => {
        //Mape Dönüştür
        'hayvanId': hayvanId,
        'asilayankisiismi': asilayankisiismi,
        'asilamaId':asilamaId,
        'asilamanot':asilamanot,
        'hayvaninkupeno': hayvaninkupeno,
        'yapilanasiismi':yapilanasiismi,
        'asilamabaslangic':asilamabaslangic,
        'asilamabitis': asilamabitis,
      };

  static AsilamaEkleFirebase fromJson(Map<String, dynamic> json) => //Mapten oluştur
      AsilamaEkleFirebase(
        asilamanot: json['asilamanot'],
        asilayankisiismi: json['asilayankisiismi'],
        hayvanId: json['hayvanId'],
        asilamaId: json['asilamaId'],
        hayvaninkupeno: json['hayvaninkupeno'],
        yapilanasiismi: json['yapilanasiismi'],
        asilamabaslangic:(json['asilamabaslangic'] as Timestamp).toDate(),
        asilamabitis:(json['asilamabitis'] as Timestamp).toDate(),
      );
}