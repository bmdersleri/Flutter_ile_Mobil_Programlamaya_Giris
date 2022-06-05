import 'package:kelimeuygulamasi/db/db/db.dart';

enum Lang { ing, tr }

Lang? chooseLang = Lang.ing;

enum Which { learned, unlearned, all }

enum forWhat { forList, forListMixed }

Which? chooseQuestionType = Which.learned;
bool listMixed = true;

List<Map<String, Object?>> lists = [];
List<bool> selectedListIndex = [];

Future getLists() async {
  lists = await DB.instance.readListsAll();

  for (int i = 0; i < lists.length; ++i) {
    selectedListIndex.add(false);
  }
}
