import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  final String namesurname;
  final String brand;
  final String bmodel;
  final String kmnow;
  final String kmtogo;
  final String serviceId;
  final DateTime datePublished;
  final List<bool> trufal;

  const Services({
    required this.namesurname,
    required this.brand,
    required this.bmodel,
    required this.kmnow,
    required this.kmtogo,
    required this.serviceId,
    required this.datePublished,
    required this.trufal,
  });

  Map<String, dynamic> toJson() => {
        "namesurname": namesurname,
        "brand": brand,
        "bmodel": bmodel,
        "kmnow": kmnow,
        "kmtogo": kmtogo,
        "serviceId": serviceId,
        "datePublished": datePublished,
        "trufal": trufal,
      };

  static Services fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Services(
      namesurname: snapshot['namesurname'],
      brand: snapshot['brand'],
      bmodel: snapshot['bmodel'],
      kmnow: snapshot['kmnow'],
      kmtogo: snapshot['kmtogo'],
      serviceId: snapshot['serviceId'],
      datePublished: snapshot['datePublished'],
      trufal: snapshot['trufal'],
    );
  }
}
