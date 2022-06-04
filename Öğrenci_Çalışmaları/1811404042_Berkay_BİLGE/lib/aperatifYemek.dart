import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endDraweMenu.dart';
import 'yemekKarti.dart';

class AperatifYemekler extends StatelessWidget {
  const AperatifYemekler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset('images/hamburger.png',
            fit: BoxFit.contain,
            width: 65,
            height: 35,
            alignment: Alignment.topLeft),
      ),
      endDrawer: DrawerMenu(),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Text(
              'Aperatifler',
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              yemekKarti(
                yemekAd: 'Zeytinyağlı Brokoli',
                yemekImage: 'brokoli',
                yemekTarif:
                    'Brokoliyi çiçeklerine ayırıp, bol suda yıkıyoruz.Havucu soyup, istediğimiz şekilde doğruyoruz.Tavaya zeytinyağını alıp, havucu ve ince kıydığımız sarımsağı koyup soteliyoruz.Brokolileri de en üste koyup, tuzunu ayarlıyoruz.1 su bardağı su koyup, fazla yıpratmadan pişiriyoruz.Ocaktan aldıktan sonra, üzerine zeytinyağı ve limon suyu gezdiriyoruz.Soğuk olarak servis ediyoruz.',
                yemekMalzeme:
                    'Yarım kg. brokoli\n1 adet havuç\n2 adet kırmızı biber\n3 diş sarımsak\nZeytinyağı\nTuz\nLimon suyu',
              ),
              yemekKarti(
                yemekAd: 'Sebzeli Haşlama',
                yemekImage: 'istockphoto-1065548372-612x612-removebg-preview 1',
                yemekMalzeme:
                    '600 gram kemiksiz parça et kuzu but, kol ya da kemiksiz dana eti\n1 adet iri kuru soğan\n4-5 diş sarımsak\n100 gram tereyağı\n2 adet iri büyük havuç\n4-5 adet iri patates\n1 limonun suyu (limon büyükse yarım limon kullanın)',
                yemekTarif:
                    'Etleri yıkayıp 1 saat kadar soğuk çeşme suyunda bekletin.Küp küp doğradığınız soğanları ve tüm haldeki sarımsakları  tereyağında orta ateşte  pembeleşene kadar kavurun.Suda bekleyen etleri süzün…suyu süzülmüş etleri tencereye ekleyerek ikiliyi yüksek ateşte kontrollü şekilde 5 dakika  kavurun…Daha sonra tencereye etlerin üstünü 2 parmak aşacak kadar sıcak su ,baharatlar ve defne yaprağını ekleyerek tencereyi kaynayana kadar yüksek ateşte kaynadıktan sonra ağır ateşte 40-50 dakika kadar kaynatın. (kaynarken suyun üstünde  oluşan köpükleri almayı unutmayın)',
              ),
              yemekKarti(
                yemekAd: 'Hellim Salatası',
                yemekImage: 'Pic',
                yemekMalzeme:
                    '250 gr hellim peyniri\nKıvırcık, yeşil soğan, maydanoz, taze nane, domates, kırmızı biber, mısır',
                yemekTarif:
                    'Hepsinden kişiye göre azar azar doğrayın. Domatesleri ve mısırı da ekleyin. Hellim peynirini küp küp doğrayıp tavaya bir damla yağ damlatıp karıştırarak kızartın.Salatanın içine dökün üzerine çok az zeytinyağ, limon, nar ekşisi ve tuz atıp karıştırın ve servis yapın. \n\n\n ',
              ),
              yemekKarti(
                yemekAd: 'Çoban Salatası',
                yemekImage: 'CobanSalatasi',
                yemekMalzeme:
                    '4 adet orta boy domates\n3 adet orta boy yeşil biber\n2 adet orta boy salatalık\n1 adet büyük boy kuru soğan\n1/4 demet maydanoz\n5 yemek kaşığı taze sıkılmış limon suyu',
                yemekTarif:
                    'Kuru soğanı küçük parçalar halinde ya da arzuya göre ince piyazlık doğrayın. Maydanozu incecik kıyın. Tüm malzemeyi salata kabında karıştırın. Salatanın sosu için; zeytinyağı, taze sıkılmış limon suyu ve tuzu küçük bir kapta karıştırdıktan sonra salatanın üzerine gezdirin.',
              ),
              yemekKarti(
                yemekAd: 'Fırında Kabak',
                yemekImage: 'Foto',
                yemekMalzeme:
                    '3 adet kabak\n3 yemek kaşığı zeytinyağıYarım çay kaşığı pul biber\nYarım çay kaşığı nane\nYarım çay kaşığı kekik',
                yemekTarif:
                    'Kabakları yıkayıp yuvarlak şekilde doğruyoruz.Pul biber, nane, kekik ve tuz bir kasede karıştırılıp kabakların üzerine serpiyoruz ve iyice karıştırıyoruz.Zeytinyağını ilave edip tekrar karıştırıyoruz.Daha sonra yağlı kağıt serilmiş fırın kabına kabakları diziyoruz.Önceden ısıtılmış 200 derece fırında kabaklar kızarana kadar pişiriyoruz.Pişen kabakları tabağa dizip üzerine sarımsaklı yoğurt gezdirip dereotu ile süslüyoruz.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
