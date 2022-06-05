final String tableNameWords = "words";

class WordTableFields {
  static final List<String> values = [id, list_id, word_ing, word_tr, status];
  static final String id = "id";
  static final String list_id = "list_id";
  static final String word_ing = "word_ing";
  static final String word_tr = "word_tr";
  static final String status = "status ";
}

class Word {
  final int? id;
  final int? list_id;
  final String? word_ing;
  final String? word_tr;
  final bool? status;

  const Word({this.id, this.list_id, this.word_ing, this.word_tr, this.status});
  Word copy(
      {int? id,
      int? list_id,
      String? word_tr,
      String? word_ing,
      bool? status}) {
    return Word(
        id: id ?? this.id,
        list_id: list_id ?? this.list_id,
        word_ing: word_ing ?? this.word_ing,
        word_tr: word_tr ?? this.word_tr,
        status: status ?? this.status);
  }

  Map<String, Object?> toJson() => {
        WordTableFields.id: id,
        WordTableFields.list_id: list_id,
        WordTableFields.word_ing: word_ing,
        WordTableFields.word_tr: word_tr,
        WordTableFields.status: status == true ? 1 : 0,
      };
  static Word fromJson(Map<String, Object?> json) => Word(
        id: json[WordTableFields.id] as int?,
        list_id: json[WordTableFields.list_id] as int?,
        word_ing: json[WordTableFields.word_ing] as String?,
        word_tr: json[WordTableFields.word_tr] as String?,
        status: json[WordTableFields.status] == 1,
      );
}
