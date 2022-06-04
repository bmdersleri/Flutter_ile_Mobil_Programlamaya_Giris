import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggy/yemekTarifi.dart';

class yemekKarti extends StatelessWidget {
  String yemekAd;
  String yemekImage;
  String yemekTarif;
  String yemekMalzeme;

  yemekKarti(
      {Key? key,
      required this.yemekAd,
      required this.yemekImage,
      required this.yemekTarif,
      required this.yemekMalzeme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Card( //Elevate edilmiş bir kart elementi.
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //aralarda bosluk bırakmak icin
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/$yemekImage.png'),
                      fit: BoxFit.cover)),
            ),
            Container(
              child: Text(
                yemekAd,
                style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 15)),
              ),
            ),
            SizedBox(
              height: 30,
              width: 130,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    //Yemek tarifi sayfasına gidiyor. Giderken aşağıdaki dataları cekiyor.
                      builder: (context) => YemekTarifi(
                            yemekAd: yemekAd,
                            yemekImage: yemekImage,
                            yemekMalzeme: yemekMalzeme,
                            yemekTarif: yemekTarif,
                          )));
                },
                child: Text(
                  'Tarife Git >',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.w700)),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 233, 255, 234), elevation: 0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
