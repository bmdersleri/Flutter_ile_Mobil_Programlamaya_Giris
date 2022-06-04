import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggy/Corbalar.dart';
import 'package:veggy/anaYemekler.dart';
import 'package:veggy/aperatifYemek.dart';
import 'package:veggy/app_Hakkinda.dart';
import 'package:veggy/yemekKarti.dart';
import 'package:veggy/yemekTarifi.dart';
import 'package:lottie/lottie.dart';

import 'endDraweMenu.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( //iskelet olusur
        appBar: AppBar( //üst bar
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Image.asset('images/hamburger.png',
              fit: BoxFit.contain,
              width: 65,
              height: 35,
              alignment: Alignment.topLeft),
        ),
        endDrawer: DrawerMenu(), //icon olusumu bu textten geliyor
        body: homePageBody());
  }
}

class homePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView( //Aşağı doğru kaydırılabilir oluşunu sağlar.
      children: [
        Container( //Hoşgeldin yazısının arkasındaki yeşil kutu
          width: 600,
          height: 250,
          color: Color.fromARGB(255, 233, 255, 234),
          child: Padding(
            padding: const EdgeInsets.all(16.0), //her yerden 16 padding verir.
            child: Column( //Textlerin yazılması için column oluşturuldu.
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              //container solundan başlaması ve textlerin ortalanması işine yarar.
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Hoşgeldin!',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    'Şöyle lezzetli bir vejeteryan yemek tarifi mi arıyorsun? Aşağıya doğru kaydırarak istediğini bulabilirsin!',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 105, 105, 105),
                            fontSize: 20)),
                  ),
                ),

              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          child: Text(
            'Senin için listeledik',
            style: GoogleFonts.inter(
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ),
        GridView.count( //ListView kullanılırsa düz bir şekilde aşağıya sıralardı.
          primary: false,
          shrinkWrap: true, //İç imajın dışarı taşmaması için kullanılır.
          crossAxisCount: 2, //bir satırda 2 element olması icin yapılır.
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
              yemekAd: 'Ispanak Çorbası',
              yemekImage: 'Spinach-Soup',
              yemekMalzeme:
                  '400 gram ıspanak\n3 yemek kaşığı sıvı yağ\n1 adet soğan \nYarım su bardağı pirinç\nYarım yemek kaşığı biber ve domates\nPul biber\nKarabiber\nTuz\n1 litre su',
              yemekTarif:
                  'Soğanımızı yemeklik doğrayalım.Sıvı yağda soğanı az kavuralım. Salçalarınızı ilave ederim.Üstüne pirinci ve yemeklik doğradığımız ıspanakları da ilave edip karıştıralım .Baharatları ,tuzunu ,suyunu koyup karıştırıp pişirmeye bırakalım.Pişmeye yakın limon tuzunu da koyalım \nAfiyet olsun.',
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
              yemekAd: 'Fırında Kabak',
              yemekImage: 'Foto',
              yemekMalzeme:
                  '3 adet kabak\n3 yemek kaşığı zeytinyağıYarım çay kaşığı pul biber\nYarım çay kaşığı nane\nYarım çay kaşığı kekik',
              yemekTarif:
                  'Kabakları yıkayıp yuvarlak şekilde doğruyoruz.Pul biber, nane, kekik ve tuz bir kasede karıştırılıp kabakların üzerine serpiyoruz ve iyice karıştırıyoruz.Zeytinyağını ilave edip tekrar karıştırıyoruz.Daha sonra yağlı kağıt serilmiş fırın kabına kabakları diziyoruz.Önceden ısıtılmış 200 derece fırında kabaklar kızarana kadar pişiriyoruz.Pişen kabakları tabağa dizip üzerine sarımsaklı yoğurt gezdirip dereotu ile süslüyoruz.',
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
    );
  }
}



// TextStyle(
                         
//                           fontSize: 20,
//                           color: Color.fromARGB(255, 105, 105, 105)),
