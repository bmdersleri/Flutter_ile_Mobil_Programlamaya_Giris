const Map<int, String> sexNames = {
  0: "Bilinmiyor",
  1: "Erkek",
  2: "Dişi",
  9: "Uygulanamaz"
};

final List<Sex> sexList = [
  Sex.fromId(0),
  Sex.fromId(1),
  Sex.fromId(2),
  Sex.fromId(9)
];

class Sex {
  int id;
  String? name;

  Sex(this.id, this.name);

  Sex.fromId(this.id) {
    name = sexNames[id] ?? '';
  }
}
