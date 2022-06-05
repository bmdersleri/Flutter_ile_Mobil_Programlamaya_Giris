import 'dart:core';
import 'package:flutter/material.dart';
import 'package:kelimeuygulamasi/db/models/words.dart';
import 'package:kelimeuygulamasi/global_variable.dart';
import 'package:kelimeuygulamasi/global_widget/app_Bar.dart';
import 'package:kelimeuygulamasi/global_widget/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../db/db/db.dart';

class WordCardsPage extends StatefulWidget {
  const WordCardsPage({Key? key}) : super(key: key);

  @override
  _WordCardsPageState createState() => _WordCardsPageState();
}

class _WordCardsPageState extends State<WordCardsPage> {
  Which _chooseQuestionType = Which.learned;
  bool _listMixed = true;

  @override
  void initState() {
    super.initState();
    getLists().then((value) => setState(() => lists));
  }

  List<Word> _words = [];

  bool start = false;
  List<bool> changeLang = [];

  void getSelectedWordOfLists(List<int> selectedListID) async {
    List<String> value = selectedListID.map((e) => e.toString()).toList();

    if (_chooseQuestionType == Which.learned) {
      _words = await DB.instance.readWordByLists(selectedListID, status: true);
    } else if (_chooseQuestionType == Which.unlearned) {
      _words = await DB.instance.readWordByLists(selectedListID, status: false);
    } else {
      _words = await DB.instance.readWordByLists(selectedListID);
    }

    if (_words.isNotEmpty) {
      for (int i = 0; i < _words.length; ++i) {
        changeLang.add(true);
      }

      if (_listMixed) _words.shuffle();
      start = true;

      setState(() {
        _words;
        start;
      });
    } else {
      toastMassage("Şeçilen şartlarda liste boş.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          context,
          left: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22,
          ),
          center: const Text(
            "Kelime Kartları",
            style: TextStyle(
                fontFamily: "carter", color: Colors.black, fontSize: 22),
          ),
          leftWidgetOnClick: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: start == false
              ? Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 0, bottom: 16),
                  padding: const EdgeInsets.only(left: 4, top: 10, right: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 221, 221, 221),
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      whichRadioButton(
                          text: "Öğrenmediklerimi Sor", value: Which.unlearned),
                      whichRadioButton(
                          text: "Öğrendiklerimi Sor", value: Which.learned),
                      whichRadioButton(text: "Hepsini Sor", value: Which.all),
                      checkbox(
                          text: "Listeyi Karıştır",
                          fWhat: forWhat.forListMixed),
                      SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Text("Lİsteler",
                            style: const TextStyle(
                                fontFamily: "RobotoRegular",
                                fontSize: 18,
                                color: Colors.black)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 0, bottom: 16),
                        height: 280,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                        child: Scrollbar(
                          thickness: 5,
                          thumbVisibility: true,
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                return checkbox(
                                    index: index,
                                    text: lists[index]['name'].toString());
                              },
                              itemCount: lists.length),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            List<int> selectedIndexNoOfList = [];
                            for (int i = 0; i < selectedListIndex.length; ++i) {
                              if (selectedListIndex[i] == true) {
                                selectedIndexNoOfList.add(i);
                              }
                            }
                            List<int> selectedListIdList = [];
                            for (int i = 0;
                                i < selectedIndexNoOfList.length;
                                ++i) {
                              selectedListIdList.add(
                                  lists[selectedIndexNoOfList[i]]['list_id']
                                      as int);
                            }

                            if (selectedListIdList.isNotEmpty) {
                              print(selectedListIdList);
                              getSelectedWordOfLists(selectedListIdList);
                            } else {
                              toastMassage("Lütfen liste seç");
                            }
                          },
                          child: const Text(
                            "Başla",
                            style: TextStyle(
                                fontFamily: "RobotoRegular",
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : CarouselSlider.builder(
                  options: CarouselOptions(height: double.infinity),
                  itemCount: _words.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    String word = "";
                    if (changeLang == Lang.tr) {
                      word = changeLang[itemIndex]
                          ? (_words[itemIndex].word_tr!)
                          : (_words[itemIndex].word_ing!);
                    } else {
                      word = changeLang[itemIndex]
                          ? (_words[itemIndex].word_ing!)
                          : (_words[itemIndex].word_tr!);
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: Stack(children: [
                            InkWell(
                              onTap: () {
                                if (changeLang[itemIndex] == true) {
                                  changeLang[itemIndex] = false;
                                } else {
                                  (changeLang[itemIndex] = true);
                                }
                                setState(() {
                                  changeLang[itemIndex];
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    left: 16, right: 16, top: 0, bottom: 16),
                                padding: const EdgeInsets.only(
                                    left: 4, top: 10, right: 4),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 221, 221, 221),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(0)),
                                ),
                                child: Text(
                                  word,
                                  style: const TextStyle(
                                      fontFamily: "robotoRegular",
                                      fontSize: 28,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Positioned(
                              child: Text(
                                (itemIndex + 1).toString() +
                                    "/" +
                                    (_words.length).toString(),
                                style: const TextStyle(
                                    fontFamily: "robotoRegular",
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              left: 30,
                              top: 10,
                            )
                          ]),
                        ),
                        SizedBox(
                          width: 160,
                          child: CheckboxListTile(
                            title: Text("Öğrendim"),
                            value: _words[itemIndex].status,
                            onChanged: (value) {
                              _words[itemIndex] =
                                  _words[itemIndex].copy(status: value);
                              DB.instance.markAsLearned(
                                  value!, _words[itemIndex].id as int);
                              toastMassage(value
                                  ? "Öğrenildi olarak işaretlendi."
                                  : "Öğrenilmedi olarak işaretlendi");

                              setState(() {
                                _words[itemIndex];
                              });
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
        ));
  }

  SizedBox whichRadioButton({@required String? text, @required Which? value}) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: ListTile(
        title: Text(
          text!,
          style: const TextStyle(fontFamily: "RobotoRegular", fontSize: 18),
        ),
        leading: Radio<Which>(
          value: value!,
          groupValue: _chooseQuestionType,
          onChanged: (Which? value) {
            setState(() {
              _chooseQuestionType = value!;
            });
          },
        ),
      ),
    );
  }

  SizedBox checkbox(
      {int index = 0, String? text, forWhat fWhat = forWhat.forList}) {
    return SizedBox(
      width: 270,
      height: 35,
      child: ListTile(
        title: Text(
          text!,
          style: const TextStyle(fontFamily: "RobotoRegular", fontSize: 18),
        ),
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Colors.deepPurpleAccent,
          hoverColor: Colors.blueAccent,
          value:
              fWhat == forWhat.forList ? selectedListIndex[index] : _listMixed,
          onChanged: (bool? value) {
            setState(() {
              if (fWhat == forWhat.forList) {
                selectedListIndex[index] = value!;
              } else {
                _listMixed = value!;
              }
            });
          },
        ),
      ),
    );
  }
}
