import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kelimeuygulamasi/db/models/words.dart';
import 'package:kelimeuygulamasi/global_variable.dart';
import 'package:kelimeuygulamasi/global_widget/app_Bar.dart';
import 'package:kelimeuygulamasi/global_widget/toast.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../db/db/db.dart';

class MultipleChoicePage extends StatefulWidget {
  const MultipleChoicePage({Key? key}) : super(key: key);

  @override
  _MultipleChoicePageState createState() => _MultipleChoicePageState();
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  Which _chooseQuestionType = Which.learned;
  bool _listMixed = true;

  @override
  void initState() {
    super.initState();
    getLists().then((value) => setState(() => lists));
  }

  List<Word> _words = [];

  bool start = false;

  List<List<String>> optionsList =
      []; //kelime listesi uzunluğu kadar şık listesi.

  List<String> correctAnswers = []; //doğru cevapları tutuyoruz.

  List<bool> clickControl = []; //kelime işaretlendi mi kontrolü.
  List<List<bool>> clickControlList = []; //hangi şık işaretlendi kontrolü

  int correctCount = 0; //doğru cevap sayısı
  int wrongCount = 0; //yanlış cevap sayısı

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
      if (_words.length > 3) {
        if (_listMixed) _words.shuffle();

        Random random = Random();

        for (int i = 0; i < _words.length; ++i) {
          clickControl.add(false);
          clickControlList.add([false, false, false, false]);

          List<String> tempOptions = [];

          while (true) {
            int rand = random
                .nextInt(_words.length); //kelime listesi uzunluğu -1 0 dahil

            if (rand != i) {
              bool isThereSame = false;
              for (var element in tempOptions) {
                if (chooseLang == Lang.ing) {
                  if (element == _words[rand].word_tr!) {
                    isThereSame = true;
                  }
                } else {
                  if (element == _words[rand].word_ing!) {
                    isThereSame = true;
                  }
                }
              }

              if (!isThereSame)
                tempOptions.add(chooseLang == Lang.ing
                    ? _words[rand].word_tr!
                    : _words[rand].word_ing!);
            }

            if (tempOptions.length == 3) {
              break;
            }
          }
          tempOptions.add(chooseLang == Lang.ing
              ? _words[i].word_tr!
              : _words[i].word_ing!);
          tempOptions.shuffle();
          correctAnswers.add(chooseLang == Lang.ing
              ? _words[i].word_tr!
              : _words[i].word_ing!);
          optionsList.add(tempOptions);
        }

        start = true;

        setState(() {
          _words;
          start;
        });
      } else {
        toastMassage("Minimum 4 kelime gerekli.");
      }
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
            "Çoktan Seçmeli",
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
                      const SizedBox(
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
                        height: 200,
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
                    return Column(
                      children: [
                        Expanded(
                          child: Stack(children: [
                            Container(
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      (chooseLang == Lang.ing
                                          ? _words[itemIndex].word_ing!
                                          : _words[itemIndex].word_tr!),
                                      style: const TextStyle(
                                          fontFamily: "robotoRegular",
                                          fontSize: 28,
                                          color: Colors.black),
                                    ),
                                    customRadioButtonList(
                                        itemIndex,
                                        optionsList[itemIndex],
                                        correctAnswers[itemIndex])
                                  ],
                                )),
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
                            ),
                            Positioned(
                              child: Text(
                                "D:" +
                                    correctCount.toString() +
                                    "/" +
                                    "Y:" +
                                    wrongCount.toString(),
                                style: const TextStyle(
                                    fontFamily: "robotoRegular",
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              right: 30,
                              top: 10,
                            )
                          ]),
                        ),
                        SizedBox(
                          width: 160,
                          child: CheckboxListTile(
                            title: const Text("Öğrendim"),
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

  Container customRadioButton(int index, List<String> options, int order) {
    Icon uncheck = const Icon(
      Icons.radio_button_off_outlined,
      size: 16,
    );
    Icon check = const Icon(
      Icons.radio_button_checked_outlined,
      size: 16,
    );

    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        children: [
          clickControlList[index][order] == false ? uncheck : check,
          const SizedBox(
            width: 18,
          ),
          Text(
            options[order],
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  Column customRadioButtonList(
      int index, List<String> options, String correctAnswer) {
    Divider dV = const Divider(
      thickness: 1,
      height: 1,
    );
    return Column(
      children: [
        dV,
        InkWell(
          onTap: () => toastMassage("Seçmek için çift tıklayın"),
          onDoubleTap: () => checker(index, 0, options, correctAnswer),
          child: customRadioButton(index, options, 0),
        ),
        dV,
        InkWell(
          onTap: () => toastMassage("Seçmek için çift tıklayın"),
          onDoubleTap: () => checker(index, 1, options, correctAnswer),
          child: customRadioButton(index, options, 1),
        ),
        dV,
        InkWell(
          onTap: () => toastMassage("Seçmek için çift tıklayın"),
          onDoubleTap: () => checker(index, 2, options, correctAnswer),
          child: customRadioButton(index, options, 2),
        ),
        dV,
        InkWell(
          onTap: () => toastMassage("Seçmek için çift tıklayın"),
          onDoubleTap: () => checker(index, 3, options, correctAnswer),
          child: customRadioButton(index, options, 3),
        ),
        dV
      ],
    );
  }

  void checker(index, order, options, correctAnswers) {
    if (clickControl[index] == false) {
      clickControl[index] = true;
      setState(() {
        clickControlList[index][order] = true;
      });
      if (options[order] == correctAnswers) {
        correctCount++;
      } else {
        wrongCount++;
      }

      if ((correctCount + wrongCount) == _words.length) {
        toastMassage("Test bitt");
      }
    }
  }
}
