import 'package:kelimeuygulamasi/db/db/shared_preferences.dart';
import 'package:kelimeuygulamasi/global_variable.dart';
import 'package:kelimeuygulamasi/global_widget/app_bar.dart';
import 'package:kelimeuygulamasi/pages/lists.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kelimeuygulamasi/pages/multiple_choice.dart';
import 'package:kelimeuygulamasi/pages/words_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String version = "";

  Container? adContainer = Container();

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    "lib/images/launcher.png",
                    height: 80,
                  ),
                  const Text(
                    "KELİME SÖZLÜĞÜM",
                    style: TextStyle(fontFamily: "Robotolight", fontSize: 26),
                  ),
                  const Text(
                    "Eğlenerek Öğren",
                    style: TextStyle(fontFamily: "Robotolight", fontSize: 16),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: const Divider(
                        color: Colors.black,
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 50, right: 8, left: 8),
                      child: const Text(
                          "Uygulama hakkında\nBu uygulama sayesinde kendi sözlüğünüzü oluşturun",
                          style: TextStyle(
                            fontFamily: "RobotoLight",
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center)),
                ],
              ),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      "-------------------------v8.9-------------------------\nElif ÖZCAN(elif.ozcan5415@gmail.com)",
                      style: TextStyle(
                          fontFamily: "RobotoLight",
                          fontSize: 14,
                          color: Color.fromARGB(255, 121, 121, 121)))),
            ],
          ),
        ),
      ),
      appBar: appBar(context,
          left: const FaIcon(
            FontAwesomeIcons.bars,
            color: Colors.black,
            size: 25,
          ),
          center: const Text("Kelime Sözlüğüm",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Carter",
                  color: Color.fromARGB(255, 31, 2, 58))),
          leftWidgetOnClick: () => {_scaffoldKey.currentState!.openDrawer()}),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                langRadioButton(
                    text: "İngilizce-Türkçe",
                    group: chooseLang,
                    value: Lang.ing),
                langRadioButton(
                    text: "Türkçe-İngilizce",
                    group: chooseLang,
                    value: Lang.tr),
                const SizedBox(
                  height: 100,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListsPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    margin: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: <Color>[
                          Color(0xff1f005c),
                          Color(0xff5b0060),
                          Color.fromARGB(255, 135, 1, 68),
                          Color(0xff870160),
                        ], // Gradient from https://learnui.design/tools/gradient-generator.html
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    child: const Text(
                      "Listelerim",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Carter",
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      card(context,
                          startColor: "#1DACC9",
                          endColor: "#0C33B2",
                          title: "Kelime Kartları", click: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WordCardsPage()));
                      }),
                      card(context,
                          startColor: "#FF3348",
                          endColor: "#B029B9",
                          title: "Çoktan Şeçmeli", click: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MultipleChoicePage()));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell card(BuildContext context,
      {@required String? startColor,
      @required String? endColor,
      @required String? title,
      @required Function? click}) {
    return InkWell(
      onTap: () => click!(),
      child: Container(
        alignment: Alignment.center,
        height: 200,
        width: MediaQuery.of(context).size.width * 0.37,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xff1f005c),
              Color(0xff5b0060),
              Color.fromARGB(255, 135, 1, 68),
              Color(0xff870160),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.mirror,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(title!,
                style: TextStyle(
                    fontSize: 28, fontFamily: "Carter", color: Colors.white),
                textAlign: TextAlign.center),
            const Icon(Icons.file_copy, size: 32, color: Colors.white)
          ],
        ),
      ),
    );
  }

  SizedBox langRadioButton(
      {@required String? text, @required Lang? value, @required Lang? group}) {
    return SizedBox(
        width: 250,
        height: 30,
        child: ListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text(
              text!,
              style: TextStyle(fontFamily: "Carter", fontSize: 20),
            ),
            leading: Radio<Lang>(
                value: value!,
                groupValue: chooseLang,
                onChanged: (Lang? value) {
                  setState(() {
                    chooseLang = value;
                  });
                  //true=>İngilizce-Türkçe
                  if (value == Lang.ing) {
                    SP.write("lang", true);
                  } else {
                    SP.write("lang", false);
                  }
                })));
  }
}
