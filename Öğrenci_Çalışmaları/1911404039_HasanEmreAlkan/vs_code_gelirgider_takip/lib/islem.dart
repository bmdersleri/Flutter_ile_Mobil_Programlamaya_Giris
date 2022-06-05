class Islem {
  String id;
  final String islemAdi;
  final double islemFiyati;
  final String islemTuru;
  final String userId;
  Islem(
      {this.id = '',
      required this.islemAdi,
      required this.islemFiyati,
      required this.islemTuru,
      required this.userId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'islemAdi': islemAdi,
        'islemFiyati': islemFiyati.toString(),
        'islemTuru': islemTuru,
        'userId': userId,
      };

  static Islem fromJson(Map<String, dynamic> json) => Islem(
      id: json['id'],
      islemAdi: json['islemAdi'],
      islemFiyati: double.parse(json['islemFiyati']),
      islemTuru: json['islemTuru'],
      userId: json['userId']);
}
