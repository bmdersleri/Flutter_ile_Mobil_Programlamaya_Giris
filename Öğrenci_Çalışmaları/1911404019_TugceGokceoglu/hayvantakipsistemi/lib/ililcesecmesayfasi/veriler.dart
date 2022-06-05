class Il {
  Il({
    required this.ilAdi,
    required this.ilceler,
  });

  String ilAdi;
  List<Ilce> ilceler;

  factory Il.fromJson(Map<String, dynamic> json) {
    var list = json["ilceler"] as List;

    List<Ilce> ilcelerList = list.map((i) => Ilce.fromJson(i)).toList();

    return Il(
      ilAdi: json["il_adi"],
      ilceler: json["ilceler"] != null ? ilcelerList : <Ilce>[],
    );
  }

  Map<String, dynamic> toJson() => {
        "il_adi": ilAdi,
        "ilceler": List<dynamic>.from(ilceler.map((x) => x.toJson())),
      };
}

class Ilce {
  Ilce({
    required this.ilceAdi,
  });

  String ilceAdi;

  factory Ilce.fromJson(Map<String, dynamic> json) => Ilce(
        ilceAdi: json["ilce_adi"],
      );

  Map<String, dynamic> toJson() => {
        "ilce_adi": ilceAdi,
      };
}