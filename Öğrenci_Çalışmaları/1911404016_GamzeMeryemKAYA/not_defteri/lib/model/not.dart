class Note {
  DateTime? tarih;
  String? onemDerecesi;
  String? baslik;
  String? icerik;
  String? resimUrl;
  bool? tamamlandiMi;

  Note(
      {required this.tarih,
      required this.onemDerecesi,
      required this.baslik,
      required this.icerik,
      required this.resimUrl,
      required this.tamamlandiMi});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['tarih'] = tarih;
    map['onemDerecesi'] = onemDerecesi;
    map['baslik'] = baslik;
    map['icerik'] = icerik;
    map['resimUrl'] = resimUrl;
    map['tamamlandiMi'] = tamamlandiMi;
    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    tarih = map['tarih'];
    onemDerecesi = map['onemDerecesi'];
    baslik = map['baslik'];
    icerik = map['icerik'];
    resimUrl = map['resimUrl'];
    tamamlandiMi = map['tamamlandiMi'];
  }
}
