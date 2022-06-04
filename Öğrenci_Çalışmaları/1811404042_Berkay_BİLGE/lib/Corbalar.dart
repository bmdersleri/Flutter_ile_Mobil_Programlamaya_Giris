import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endDraweMenu.dart';
import 'yemekKarti.dart';

class Corbalar extends StatelessWidget {
  const Corbalar({Key? key}) : super(key: key);

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
              'Çorbalar',
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
            ),
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: 2,
            children: [
              yemekKarti(
                yemekAd: 'Ispanak Çorbası',
                yemekImage: 'Spinach-Soup',
                yemekMalzeme:
                    '400 gram ıspanak\n3 yemek kaşığı sıvı yağ\n1 adet soğan \nYarım su bardağı pirinç\nYarım yemek kaşığı biber ve domates\nPul biber\nKarabiber\nTuz\n1 litre su',
                yemekTarif:
                    'Soğanımızı yemeklik doğrayalım.Sıvı yağda soğanı az kavuralım. Salçalarınızı ilave ederim.Üstüne pirinci ve yemeklik doğradığımız ıspanakları da ilave edip karıştıralım .Baharatları ,tuzunu ,suyunu koyup karıştırıp pişirmeye bırakalım.Pişmeye yakın limon tuzunu da koyalım \nAfiyet olsun.',
              ),
              yemekKarti(
                yemekAd: 'Tarhana Çorbası',
                yemekImage: 'TarhanaCorbasi',
                yemekMalzeme:
                    '3 yemek kaşığı ev tarhanası\n1 yemek kaşığı nane\n2 yemek kaşığı sıvı yağ\n1 yemek kaşığı salça\n6 su bardağı su',
                yemekTarif:
                    'Tenceremizin içerisine sıvı yağ, nane, salça, baharatlar ve tarhanayı ekleyip biraz karıştırarak kavuruyoruz. Dilerseniz tereyağı da kullanabilirsiniz.( Veya tarhanayı suyu ekledikten sonra ekleyip çırpıcı ile karıştırabilirsiniz. böylelikle topaklanma ihtimali azalır.)Suyu yavaş yavaş ilave ediyoruz ve devamlı karıştırarak pişiriyoruz. Topaklanmaması için tel çırpıcı ile karıştırabilirsiniz.Kaynadıktan sonra 5 dk daha bekleyip ocaktan alıyoruz, çorbamızı…',
              ),
              yemekKarti(
                yemekAd: 'Mercimek Çorbası',
                yemekImage: 'kirmizi-mercimek-corbasi-removebg-preview 1',
                yemekMalzeme:
                    '2 su bardağı kırmızı mercimek\n1 adet soğan\n2 yemek kaşığı un\n1 adet havuç\nYarım yemek kaşığı biber ya da  domates salçası (rengi kırmızı olsun isterseniz artırabilir ya da hiç kullanmayabilirsiniz)',
                yemekTarif:
                    'Kırmızı mercimek çorbası için sıvı yağı tencereye alınarak yemeklik doğranan soğanlar hafif pembeleşinceye kadar kavrulur.Salça kullanılacak ise salça ilave edilir, kavrulduktan sonra küp küp doğranmış havuç ve iyice yıkanıp suyu süzülen mercimekler ilave edilir.Üzerine su eklenerek karıştırılır ve tencerenin kapağı kapatılır. Çorbamız kaynayana kadar orta ateşte, kaynadıktan sonra mercimekler ve havuçlar yumuşayana kadar ara ara karıştırılarak kısık ateşte pişirilir.Çorba piştikten sonra el blenderı ile güzelce ezilir. Eğer blenderiniz yoksa süzgeçten de geçirebilirsiniz.Karabiber, tuz ve isteğe bağlı olarak kimyon eklenir ve karıştırılır. 5 dakika daha pişirelerek ocaktan alınır.Mercimek çorbası servis kasesine alındıktan sonra üzerine kırmızı biberli sos gezdirilir ve bir dilim limon ile servis edilir.',
              ),
              yemekKarti(
                yemekAd: 'Domates Çorbası',
                yemekImage: 'lokanda-usulu-domates-removebg-preview 1',
                yemekMalzeme:
                    '4-5 adet olgun domates\n2 çorba kaşığı tereyağı\n3 çorba kaşığı un\n1 litre sıcak su\n1 çorba kaşığı rendelenmiş taze kaşar',
                yemekTarif:
                    'Domates çorbası yapmak için yağ ve un bir tencerede hafifçe kavrulur.Diğer taraftan kabuğu çıkarılıp, küp küp kesilmiş domates robottan geçirilip bu karışıma ilave edilir, birkaç dakika kavrulur.Ara verilmeden bir litre kadar su ilave edilip karıştırma işlemini sürdürülür. 15 dakika bu şekilde kaynatılır.Daha sonra süt ilave edilip birkaç dakika daha kaynatılarak tuzu ilave edilip ocaktan alınır.Arzuya göre servis yaparken üzerine kaşar peyniri rendesi ilave edilir. Domates çorbamız servise hazır',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
