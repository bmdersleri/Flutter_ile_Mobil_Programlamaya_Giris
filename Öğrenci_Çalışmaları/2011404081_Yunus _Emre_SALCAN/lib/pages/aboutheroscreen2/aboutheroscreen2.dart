import 'package:flutter/material.dart';
import '../../ui/export.dart';


class Aboutheroscreen2 extends StatefulWidget {
  const Aboutheroscreen2({Key? key}) : super(key: key);

  @override
  _Aboutheroscreen1State createState() => _Aboutheroscreen1State();
}

class _Aboutheroscreen1State extends State<Aboutheroscreen2> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: FvColors.aboutscreen1Background,
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 100, top: 15),
                  child: Text(
                    "REYNA -Düellocu",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: FvColors.abouttextview2FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 13),
                child: SizedBox(
                  height: 342,
                  width: 333,
                  child:
                  Image.asset("assets/reyna.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 161, top: 3),
                  child: Text(
                    "-REYNA-",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      color: FvColors.abouttextview2FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 0, top: 7),
                  child: Text(
                    "Meksika'nın kalbinden kopup gelmiş Reyna teke tek çatışmalarda düşmanını ezer ve aldığı her skorla daha da coşar. Yapabilecekleri tamamen saf beceri gerektirir ve onu ciddi şekilde performansa dayalı kılar.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 96, top: 80),
                  child: Text(
                    "Ajan Yetenekleri",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: FvColors.abouttextview2FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 7, top: 24),
                  child: Text(
                    "KEM GÖZ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 146, top: 9),
                child: SizedBox(
                  height: 100,
                  width: 135,
                  child: Image.asset(
                      "assets/reynagoz.jpg"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 216, top: 1),
                  child: Text(
                    "C",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 7, top: 1),
                  child: Text(
                    "Yok edilebilir, ruhtan bir küre KUŞAN. Gözü yakın mesafede ileri doğru kullanmak için ETKİNLEŞTİR. Göz, ona bakan tüm düşmanların uzağı görmesini engeller.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 17, top: 19),
                  child: Text(
                    "AZLET",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 148, top: 5),
                child: SizedBox(
                  height: 112,
                  width: 157,
                  child: Image.asset(
                      "assets/reynahız.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 227, top: 6),
                  child: Text(
                    "E",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 1, top: 1),
                  child: Text(
                    "Yakınlardaki bir ruh küresini HEMEN tüketerek kısa süreliğine saydamlaş. İMPARATORİÇE etkinse, aynı zamanda görünmez olursun",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 17, top: 24),
                  child: Text(
                    "İMPARATORİÇE",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 154, top: 31),
                child: SizedBox(
                  height: 127,
                  width: 132,
                  child: Image.asset(
                      "assets/reynax.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 220, top: 9),
                  child: Text(
                    "X",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 1, top: 8),
                  child: Text(
                    "HEMEN bir coşku haline geçersin. Atış, kuşanma ve doldurma hızı ciddi şekilde artar. Düşman öldürmek, süreyi yeniler.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 17, top: 20),
                  child: Text(
                    "SÖMÜR",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 157, top: 3),
                child: SizedBox(
                  height: 129,
                  width: 139,
                  child: Image.asset("assets/reynaq.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 220, top: 19),
                  child: Text(
                    "Q ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 8, top: 6),
                  child: Text(
                    "Reyna'nın öldürdüğü düşmanlar, arkalarında 3 saniyeliğine Ruh Küreleri bırakır. HEMEN yakınlardaki bir ruh küresini tüket ve kısa süreliğine hızla can yenile. Bu yetenekle 100'ü geçen can yenilemeleri zamanla azalır. İMPARATORİÇE etkinse yetenek otomatik şekilde, küreyi harcamadan kullanılır.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17,
                      color: FvColors.abouttextview4FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
          ]),
        ));
  }
}
