import 'package:flutter/material.dart';
import '../../ui/export.dart';


class Aboutheroscreen1 extends StatefulWidget {
  const Aboutheroscreen1({Key? key}) : super(key: key);

  @override
  _Aboutheroscreen1State createState() => _Aboutheroscreen1State();
}

class _Aboutheroscreen1State extends State<Aboutheroscreen1> {
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
                    "RAZE -Düellocu",
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
                  Image.asset("assets/Ekrangrnts_ImageView_23-333x342.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 161, top: 3),
                  child: Text(
                    "-RAZE-",
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
                    "Bomba gibi bir kişiliğe ve kocaman silahlara sahip olan Raze, aramıza Brezilya'dan katılıyor. Kafa göz dalan oyun tarzıyla düşmanları saklandıkları deliklerden çıkarmakta ve dar alanları ''bam bam bam'' temizlemekte üstüne yok .. ",
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
                    "Boom Bot",
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
                  height: 95,
                  width: 135,
                  child: Image.asset(
                      "assets/stsmallxpadxfff_ImageView_8-135x95.png"),
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
                    "Yerde düz bir çizgide hareket eden ve duvarlardan sıçrayan bir Boom Botu konuşlandırın. Ön konisindeki tüm düşmanlara kilitlenir ve onları kovalar, onlara ulaşırsa ağır hasar için patlar",
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
                    "Bomba",
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
                      "assets/stsmallxpadxfff_ImageView_16-157x112.png"),
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
                    "Bir parça tesirli el bombası KUŞAN. Fırlatmak için ATEŞ ET. Hasar veren bomba, her biri menzilindeki herkese hasar veren bombacıklar oluşturur",
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
                    "Nefes kesen",
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
                      "assets/vitalygavrilovvitalygavrilovb_ImageView_17-132x127.png"),
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
                    "Bir roketatar KUŞAN. Temas ettiği her şeye muazzam alan hasarı veren bir roket fırlatmak için ATEŞ ET.",
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
                    "Patlayıcı Çanta",
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
                  child: Image.asset("assets/images_ImageView_19-139x129.png"),
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
                    "HEMEN, zemine yapışan bir Patlayıcı Çanta fırlat. Elinden çıkan çantayı patlatmak için TEKRAR KULLAN. İsabet ettiği her şeye hasar verir ve onları yerinden oynatır. Raze bu yeteneğinden doğrudan hasar almaz fakat çok yükseğe fırlatılırsa düşme hasarı alabilir.",
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
