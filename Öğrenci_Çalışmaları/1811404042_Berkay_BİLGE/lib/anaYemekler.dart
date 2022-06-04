import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endDraweMenu.dart';
import 'yemekKarti.dart';

class AnaYemekler extends StatelessWidget {
  const AnaYemekler({Key? key}) : super(key: key);

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
              'Ana Yemekler',
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
                yemekAd: 'Hellim Salatası',
                yemekImage: 'Pic',
                yemekMalzeme:
                    '250 gr hellim peyniri\nKıvırcık, yeşil soğan, maydanoz, taze nane, domates, kırmızı biber, mısır',
                yemekTarif:
                    'Hepsinden kişiye göre azar azar doğrayın. Domatesleri ve mısırı da ekleyin. Hellim peynirini küp küp doğrayıp tavaya bir damla yağ damlatıp karıştırarak kızartın.Salatanın içine dökün üzerine çok az zeytinyağ, limon, nar ekşisi ve tuz atıp karıştırın ve servis yapın. \n\n\n ',
              ),
              yemekKarti(
                yemekAd: 'Margarita Pizza',
                yemekImage: 'pizza',
                yemekMalzeme:
                    '2,5su bardağı un\n2,5 yemek kaşığı zeytinyağı\n2 su bardağı ılık su\n1/2tatlı kaşığı kuru maya\n1/2 tatlı kaşığı tuz',
                yemekTarif:
                    'Ilık su, toz şeker ve kuru mayayı küçük bir kapta karıştırıp, 10 dakika kadar bekletin.Elenmiş unu karıştırma kabına aktarın. Orta kısmını havuz gibi açın. Unun kenar kısımlarına tuzu serpin. Hazırladığınız maya karışımını orta kısmına boşaltın. Zeytinyağını katın.Tüm malzemeyi orta kısımdan dışa doğru karıştırarak harmanlayın. Toparlanan hamuru yumak haline getirin. Ayrı bir kaba alın. Üzerini streç film ile kapladıktan sonra oda ısısında 30 dakika kadar bekletin.Pizzanın sosu için; kabuğunu soyduğunuz domatesleri rendeleyin. Zeytinyağını sos tenceresinde kızdırın. Rendelenmiş domatesi 3- 4 dakika kadar kaynatın. Kekiği ekleyin ve karıştırın. Hazırladığınız sosu buzdolabında soğutun.Mayalanan hamuru iki eşit bezeye ayırın. Hafif bir şekilde unlanmış mutfak tezgahı üzerinde elinizle büyüterek yuvarlak şeklinde açın.Açılan hamurları dikkatli bir şekilde fırın tepsilerine ayrı ayrı yerleştirin. Buram buram kekik kokan domates sosunu bir kepçe yardımıyla pizzanın orta kısmından başlayarak kenarlara doğru yayın. Kenar kısımlarında yaklaşık bir parmak kalınlığında pay bırakmayı unutmayın.Rendelenmiş mozzarella peynirini pizzaların üzerine eşit olarak dağıtın. Önceden ısıtılmış 250 derece fırında yaklaşık 15 dakika peynirler eriyip, kızarana kadar pişirin.',
              ),
              yemekKarti(
                yemekAd: 'Brokoli Pizza',
                yemekImage: 'veggie-pizza 1',
                yemekMalzeme:
                    '400 gr brokoli\n1, 5 tatlı kaşığı kuru maya\n1 su bardağı kadar ılık su\n1, 5 çay kaşığı şeker\n1, 5 tatlı kaşığı tuz',
                yemekTarif:
                    'Unun içine tuzu ilave edin.Ayrı bir kapta ılık su, kuru maya ve şekeri ilave edip, mayalanması için 5 dakika hafif hafif çırpın.Ardından unu ilave edin. Hafif ele yapışan yumuşak bir kıvam olacak unu azar azar ekleyerek ayarlayın yoksa hamur sert olabilir.10 dakika kadar güzelce yoğurun ve 1 saat mayalanması için bekletin.Mayalanan hamuru 4 e bölüp unlu tezhahta oklavayla açın.Yağlı kağıt serili tepsilerin üzerine -her hamurun altında yarım yemek kaşığı kadar olacak şekilde- mısır unu serpin.Hamurları tepsiye alıp çatalla üzerlerini delin.5 dakika kadar 200 derece fırında renk almayacak şekilde sadece hamurları pişirn.Fırından çıkarıp sosunu sürün ve malzemeleri dizin.Tekrar 200 derecede fırına verip 15-20 dakika pişirin.',
              ),
              yemekKarti(
                yemekAd: 'Patates Yemeği',
                yemekImage:
                    'patates-yemegi-resimli-yemek-tarifi_7_-removebg-preview 1',
                yemekMalzeme:
                    '3 adet patates\n1 adet soğan\n2 kaşık biber salçası\n3 yemek kaşığı yağ\n1 tatlı kaşığı tepeleme olmasın pul biber\n1 tatlı kaşığı tuz ',
                yemekTarif:
                    'İlk başta sıcak suyu hazırlıyoruz.Daha sonra soğanı ince ince doğrayıp yağı koyup kavuruyoruz.Pembeleşince salçayı koyup kavurmaya devam ediyoruz.Daha sonra patatesi pul biberi tuzu ilave edip suyunu ekleyip pişmesini bekliyoruz. Afiyet olsun.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
