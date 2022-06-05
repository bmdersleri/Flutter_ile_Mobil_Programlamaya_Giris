import 'package:flutter/material.dart';

class Filmler {
  String baslik;
  String filmAciklama;
  String resim;
  int yapimYili;
  String fragman;

  Filmler(
      {required this.baslik,
        required this.filmAciklama,
        required this.resim,
        required this.yapimYili,
        required this.fragman
      });
}

List<Filmler> filmList = [
  Filmler(
      baslik: "Esaretin Bedeli",
      filmAciklama:
      "Esaretin Bedeli, Andy ve Red isimli iki mahkumun parmaklıklar ardında kurdukları dünyanın hikayesini anlatıyor."
          "Andy Dufresne, genç ve başarılı bir bankerdir. Karısını ve karısının sevgilisini öldürmek suçundan yargılanır ve ömür boyu hapis cezası alır."
          " Shawsank Hapishanesi'nde dayak, işkence, tecavüz, her türlü durum yaşanmaktadır fakat Andy gene de hayata bağlı ve iyimserdir. Bu tutumu etrafındakileri de etkiler. Andy umutlu bakış açısıyla çevresindeki tüm mahkumları, parmaklıklar arkasında bile özgür bir yaşam olabileceğine inandırır. Andy'nin bu çabalarına ortak olacak bir arkadaşı da olacaktır: Red.Bir Stephen King uyarlaması olan filmde Morgan Freeman ve Tim Robbins başrolde. Film, 1995'te, aralarında en iyi film adaylığı da olmak üzere tam 7 dalda Oscar'a aday gösterildi.",
      yapimYili: 1994,
      resim:
      'https://upload.wikimedia.org/wikipedia/en/8/81/ShawshankRedemptionMoviePoster.jpg',
      fragman:
      '8n0M3HQ3dbo'

  ),
  Filmler(
      baslik: 'Jumanji',
      filmAciklama:
      "Bir kız ve erkek kardeşi eski ve esrarengiz bir masa üstü aile oyununu keşfedip oynamaya baladıklarında, aynı oyun tarafından 25 yıl önce yutulmuş Alan Parrish’in serbest kalmasına sebep olurlar."
      "Yutulduğu zaman onlar gibi bir çocuk olan Parrish şimdi koca bir adamdır.Oysa oyun bitmemiştir ve önce evleri sonra tüm kasaba oyunun içinden çıkıp gelen muzip maymunlar, yokedici gergedanlar, filler, aslanlar ve her türden hayvan tarafından işgal edilmeye başlanır."
      "Yarım kalan oyunu durdurmanın tek yolu, tabii ki oyunu kazanıp bitirmektir. Peki kahramanlarımız bunu anladıklarında her şey için çok mu geç olmuştur? 90’lı yılların en eğlendirici filmlerinden biri olan Jumanji,"
      "sadece Robin Williams’ın parıltılı oyunculuğuyla değil, aralarında o zamanki çocuk oyuncu Kirsten Dunst’un da bulunduğu geniş kadrosuyla ve elbette mükemmel özel efektleriyle uzun yıllar unutulmayacak bir film.",
      yapimYili: 2019,
      resim: 'https://i.ytimg.com/vi/MJuFdpVCcsY/movieposter_en.jpg',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: 'The Godfather (Baba)',
      filmAciklama:
      "Sicilya'dan göç eden Corleone ailesi, Amerika'da yerleşme çabalarını sürdürürken kendilerine kaba kuvvet kullanmaya kalkan "
          "ve yapmaya kalktıkları her işten haraç isteyen bir takım kimliği belirsiz kişilere karşı onlar da kaba kuvvet kullanmaya "
          "ve bunda da başarılı olmaya başlayınca kendilerini tahmin bile edemeyecekleri bir yaşantının içinde bulurlar. Bir taraftan "
          "son derece katı örf ve aile yaşantısı diğer tarafta ise acımasızca önlerine çıkanları yok etmeye başlayan Corleone ailesi "
          "bir müddet sonra Amerika'nın en korkulan mafya topluluğu haline gelmiştir. Kendileri her ne kadar mafya değil bir aile "
          "olduklarını söyleseler de.",
      yapimYili: 1972,
      resim:
      'https://upload.wikimedia.org/wikipedia/pt/a/af/The_Godfather%2C_The_Game.jpg',
      fragman:
      '8n0M3HQ3dbo'),

  Filmler(
      baslik: "12 Öfkeli Adam",
      yapimYili: 1957,
      filmAciklama:
      "12 Öfkeli Adam, cinayetle suçlanan bir genç ile ilgili karar vermekle yükümlü 12 jüri üyesinin karar verme sürecini konu ediyor. "
          "Latin Amerikalı bir genç adam, babasını öldürdüğü gerekçesiyle cinayetle suçlanır. Sanığın kaybettiğini söylediği bir bıçak ise "
          "cinayetin işlendiği odada bulunmuştur, gencin mahkemeye sunduğu savunma zayıftır ve olan biteni duyduklarını söyleyen pek çok tanık vardır. "
          "Sanık suçlu bulunduğu taktirde idama mahkum edilecektir.Jüri sonuçları pek de şaşırtıcı değildir: 12 jüri üyesinden sadece sekiz numaralı jüri "
          "üyesi Davis 'suçsuz' hükmü yönünde oy vermiştir. Davis’in jüri üyelerini ikna etmeye çalışması esnasında her jüri üyesinin 'suçlu' kararı vermesinin "
          "arkasında ise, aralarında yabancı düşmanlığı, kanuna aşırı güven, çoğunluğa uyma, geçmişle hesaplaşma gibi farklı kişisel sebepler olduğu ortaya çıkacaktır.",
      resim: 'https://flxt.tmsimg.com/assets/p2084_p_v10_ad.jpg',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: "Schindler'in Listesi",
      yapimYili: 1993,
      filmAciklama:
      "Schindler’in Listesi, Oskar Schindler adlı bir Alman işadamının 2. Dünya Savaşı zamanında Polonya’da kurduğu fabrikada Yahudi "
          "işçileri çalıştırması ve bu sayede 1100 Yahudi’nin hayatını kurtarmasını konu alıyor. Gerçek bir hayat hikayesinden uyarlanan film, "
          "ünlü yönetmen Steven Spielberg’in en önemli yapıtları arasında sayılan ve ona Oscar kazandıran bir yapımdır. Film, 1994 yılında 12 dalda "
          "Oscar’a aday olmuş ve 7 dalda ödül kazanmıştı. Filmin kazandığı Oscar’lar şöyle : En İyi Film, Yönetim, Kurgu, Sanat Yönetimi, Görüntü, "
          "Özgün Müzik ve Senaryo Uyarlaması.",
      resim:
      'https://cdn.hmv.com/r/w-1280/hmv/files/8f/8ff0f081-9bc4-418a-9670-df124169f630.jpg',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: "Ucuz Roman",
      yapimYili: 1994,
      filmAciklama:
      "Ucuz Roman'da Honey Bunny ve Pumpkin, hayatlarına biraz hareket katmak isteyen genç ve birbirine aşık bir çift küçük soyguncudur. "
          "Öteyandan, iki kaşarlanmış gangster, Vincent Vega ve Jules, günlük işlerinden biri olarak, patronlarına ödemeyi geciktiren bir "
          "kaç sahetekar genci vurmaya giderler. Vincent patronun güzel ve genç karısına bebek bakıcılığı yapmakla da görevlendirilirken "
          "ortağı suç yaşamına son vermeye karar verir. Cesur bir boksör ise para karşılığı hile yapmayı reddederek şehirden kaçar. "
          "Kader bu aykırı tipleri muhteşem bir şekilde bir araya getirecek, yollarını kesiştirecektir.Ucuz Roman, o yıl tam 7 dalda "
          "Oscar'a aday gösterilmiş ve En İyi Orijinal Senaryo Oscarı'nı almıştır. Ayrıca 1994 Cannes Film Festivali'nde en iyi film ödülü "
          "olan Altın Palmiye Ödülü'nün de sahibidir.",
      resim:
      'https://cdn.europosters.eu/image/750/posters/pulp-fiction-cover-i1288.jpg',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: "İyi, Kötü, Çirkin",
      yapimYili: 1966,
      filmAciklama:
      "İyi, Kötü ve Çirkin, üç silah arkadaşının maceralarını konu ediyor. Ortak bir hedefe doğru değişik nedenlerle yol almakta "
          "olan üç silah arkadaşı aslında kader açısından yolları kesişmiş insanlardır. İsimleri İyi, Kötü ve Çirkin olan bu kişiler "
          "için o dönemdeki Amerikan İç Savaşı bir araçtır. İyi ile Çirkin’in risk barındıran ancak iyi para getiren işleri mevcuttur. "
          "Çirkin, aranan azılı bir suçlu olduğu için İyi onu adalete teslim edip önce ödülünü alıyor sonra da darağacından riskli bir "
          "metot ile kurtarıp bir sonraki işe kadar sağ kalmasını sağlamaktadır. Bir gün gizli bir hazinenin ortaya çıkmasıyla ikilinin "
          "araları bozulur. Onlar birbirleriyle didişirken ortaya üçüncü bir hazine avcısı çıkar; o da Kötü adındaki kişidir. Artık her "
          "şeyin başka türlü yaşanma zamanıdır...",
      resim:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhUFxJokuoS8ttyvmCdIxDTeDTv6hpipGQqg&usqp=CAU',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: "Yüzüklerin Efendisi: Yüzük Kardeşiliği",
      yapimYili: 2001,
      filmAciklama:
      "Yüzüklerin Efendisi: Yüzük Kardeşliği, dünyanın kaderini değişterecek olan yüzükten kurtulmak için "
          "verilen mücadeleyi konu ediyor. Yıllar önce üretilen ve Orta Dünya topraklarına kandan başka hiçbir şey getirmeyen "
          "yüzüklerin sonuncusu, üretiminden yüz yıllar sonra ortaya çıkar. Amcasının kendisine emanet ettiği yüzüğün nelere kadir "
          "olduğundan habersiz olan Frodo, büyücü Gandalf'ın anlattıkları sonrasında dehşete kapılır. Bu yüzükten ve müstakbel "
          "savaşlardan kurtulmanın tek yolu, gücünü toplamaya çalışan Sauron'u da engellemek için bu yüzüğü yok etmektir. "
          "Yüzüğü yok edilebileceği tek yer olan Mordor'a götürmek için kendini feda eden savaşçılardan oluşan bir ekip oluşturulur. "
          "Çok uzun ve çetin geçecek olan yolculuk başlar. Orta Dünya'nın kaderi, bu insanların ellerindedir.",
      resim:
      'https://play-lh.googleusercontent.com/OkbZGHFUkGrqnPycygoqxbAJBE1WzR28vQbifQ-c5aNAapFl8F-eGeipwkweFVYYSMQQTcMvcDte_7HpwA',
      fragman:
      '8n0M3HQ3dbo'),
  Filmler(
      baslik: "Dövüş Kulübü",
      yapimYili: 1999,
      filmAciklama:
      "Dövüş Kulübünün birinci kuralı: Asla Dövüş Kulübü hakkında konuşma... Dövüş Kulübünün ikinci kuralı: Asla ve asla dövüş kulübü hakkında konuşma... "
          "Jack, hayatın sıradanlığına kapılmış bir sigorta memurudur. Uzun bir süredir 'insomnia' yani uykusuzluk hastalığından şikayetçidir. Kendi psikolojik "
          "sıkıntılarından kurtulabilmek adına grup terapilerine katılmaktadır. Terapiler esnasında Marla adında bir kızla tanışır. Bir süre sonra da hayatını "
          "değiştirecek olan Tyler Durden ile... Durden, Jack'in ulaşmak istediği tüm hedeflere ulaşmış olan bir adamdır ve Jack'i asla hakkında konuşulmaması "
          "gereken bir organizasyon olan 'Dövüş Kulübü' ile tanıştıracaktır. David Fincher'ın kısa sürede kült mertebesine erişen filminin popülerliği dillere destan. "
          "Filmin başrollerinde de Brad Pitt, Edward Norton ve Helena Bonham Carter gibi ünlü simaları görmek mümkün...",
      resim:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrNIwynUBddelUUkFGRoSpFGGKzmg3JGSNzeSevDgvvqNw2rwFmOCGgLgXGIL4x4RnLnk&usqp=CAU',
      fragman:
      '8n0M3HQ3dbo')
];
