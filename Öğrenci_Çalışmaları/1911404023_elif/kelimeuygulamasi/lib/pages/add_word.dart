import 'package:flutter/material.dart';
import 'package:kelimeuygulamasi/db/db/db.dart';
import 'package:kelimeuygulamasi/db/models/words.dart';
import 'package:kelimeuygulamasi/global_widget/app_Bar.dart';
import 'package:kelimeuygulamasi/global_widget/text_field_builder.dart';

import '../global_widget/text_field_builder.dart';
import '../global_widget/toast.dart';

class AddWordPage extends StatefulWidget {
  final int? listID;
  final String? listName;
  const AddWordPage(this.listID, this.listName, {Key? key}) : super(key: key);

  @override
  _AddWordPageState createState() => _AddWordPageState(
        listID: listID,
        listName: listName,
      );
}

class _AddWordPageState extends State<AddWordPage> {
  int? listID;
  String? listName;
  _AddWordPageState({@required this.listID, @required this.listName});

  List<TextEditingController> wordTextEditingList = [];
  List<Row> wordListField = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 6; ++i)
      wordTextEditingList.add(TextEditingController());

    for (int i = 0; i < 3; ++i) {
      debugPrint("====>" + (2 * i).toString() + "  " + (2 * i + 1).toString());

      wordListField.add(Row(children: [
        Expanded(
            child: textFieldBuilder(
                textEditingController: wordTextEditingList[2 * i])),
        Expanded(
            child: textFieldBuilder(
                textEditingController: wordTextEditingList[2 * i + 1]))
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,
          left: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
          center: Text(
            listName!,
            style: TextStyle(
                fontFamily: "carter", fontSize: 22, color: Colors.black),
          ),
          right: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
          leftWidgetOnClick: () => Navigator.pop(context)),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("İngilizce",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "RobotoRegular")),
                      Text("Türkçe",
                          style: TextStyle(
                              fontSize: 18, fontFamily: "RobotoRegular"))
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: wordListField),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    actionButton(addRow, Icons.add),
                    actionButton(save, Icons.save),
                    actionButton(deleteRow, Icons.remove),
                  ],
                )
              ],
            )),
      ),
    );
  }

  void addRow() {
    wordTextEditingList.add(TextEditingController());
    wordTextEditingList.add(TextEditingController());

    wordListField.add(Row(
      children: [
        Expanded(
            child: textFieldBuilder(
                textEditingController:
                    wordTextEditingList[wordTextEditingList.length - 2])),
        Expanded(
            child: textFieldBuilder(
                textEditingController:
                    wordTextEditingList[wordTextEditingList.length - 1])),
      ],
    ));
    setState(() => wordListField);
  }

  void save() async {
    int counter = 0;
    bool notEmptyPair = false;

    for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
      String ing = wordTextEditingList[2 * i].text;
      String tr = wordTextEditingList[2 * i + 1].text;

      if (!ing.isEmpty && !tr.isEmpty) {
        counter++;
      } else {
        notEmptyPair = true;
      }
    }
    if (counter >= 1) {
      if (notEmptyPair == false) {
        for (int i = 0; i < wordTextEditingList.length / 2; ++i) {
          String ing = wordTextEditingList[2 * i].text;
          String tr = wordTextEditingList[2 * i + 1].text;

          Word word = await DB.instance.insertWord(
              Word(list_id: listID, word_ing: ing, word_tr: tr, status: false));
          debugPrint(word.id.toString() +
              " " +
              word.list_id.toString() +
              "" +
              word.word_ing.toString() +
              "" +
              word.word_tr.toString() +
              "" +
              word.status.toString());
        }
        toastMassage("Listeler oluşturuldu.");
        wordTextEditingList.forEach((element) {
          element.clear();
        });
      } else {
        toastMassage("Lütfen boş alanları doldurun");
      }
    } else {
      toastMassage("Minimum 1 çift dolu olmalıdır.");
    }
  }

  void deleteRow() {
    if (wordListField.length != 1) {
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);
      wordTextEditingList.removeAt(wordTextEditingList.length - 1);

      wordListField.removeAt(wordListField.length - 1);
      setState(() => wordListField);
    } else {
      toastMassage("Minimum 1 çift gerekli.");
    }
  }

  InkWell actionButton(Function() click, IconData icon) {
    return InkWell(
      onTap: () => click(),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(bottom: 10),
        child: Icon(icon, size: 28),
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
    );
  }
}
