import 'package:flutter/material.dart';
import '../../ui/export.dart';

class Abappscreen1 extends StatefulWidget {
  const Abappscreen1({Key? key}) : super(key: key);

  @override
  _Abappscreen1State createState() => _Abappscreen1State();
}

class _Abappscreen1State extends State<Abappscreen1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: FvColors.ascreen1Background,
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 61, top: 10),
                child: SizedBox(
                  height: 288,
                  width: 291,
                  child: Image.asset("assets/image_ImageView_5-291x288.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 82, top: 0),
                  child: Text(
                    "Gamer Guide",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 42,
                      color: FvColors.atextview3FontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: const Padding(
                      padding: const EdgeInsets.only(left: 18, top: 11),
                      child: Text(
                        "Uygulamamız ilk olarak statik olrak gelistirilmistir.Beta versiyonu olan bu uygulma ileride dinamik hale gelcektir.  Uygulamamız bütün oyun severlere hitap etmektedir güncel olarak yüksek oyunculu oyunlar hakkında bilgiler içermektedir.Oyunları oynarken nasıl daha fazla efektif olabilir,oyunlar hakkında kimsenin bilmedigi hareketleri oyun hakkındaki bilgileri bu uygulamamızda bulabilirsiniz. ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          color: FvColors.atextview3FontColor,
                          fontWeight: FontWeight.w400,
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                const Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "Beta sürümünden sonra gelecekler:"


                          " -Oyunların lineuplarını videolu sekilde gösterme",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        color: FvColors.atextview3FontColor,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
              ],
            ),
            const Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "-Giris yapabilme ve oyunlar hakkında yorumlar yapabilme",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: FvColors.atextview3FontColor,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "-Butun oyunlar hakkında bilgiler                        ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: FvColors.atextview3FontColor,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const Padding(
                padding: const EdgeInsets.all(1),
                child: Text(
                  "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                    color: FvColors.atextview3FontColor,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 168, top: 25),
                child: SizedBox(
                  height: 46,
                  width: 79,
                  child: Image.asset("assets/img.png"),
                ),
              ),
            ),
          ]),
        ));
  }
}
