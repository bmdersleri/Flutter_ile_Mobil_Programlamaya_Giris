import 'dart:math';

class SuggestParameters{

  static int maxPageStartSearch = 400;//400. sayfadan başlıyor yoksa 200 e düşüyor şeklinde ilerliyor
  static int pageSearchNow = 1;

  //Maksimum kaç arama sonunda veri bulamadıysa duracak!
  static int maxPageChangeCount = 25;
  static int pageChangeCount = 0;

  static int maxSearchCount = 150;

  static List<int> lookedPages = [];
  static String authority = "moviesdatabase.p.rapidapi.com";
  static String path = "/titles";
  static Map<String,dynamic> params = {
    //Filter Values ile doldurulacak
  };
  static final Map<String,String>? headers1 = {
    "x-rapidapi-key":
    "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
    "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
  };


  static int GetNewPage(){
    //Direk olarak yarıya bölmesin diye arama sayısı arttıkça daha çok azalsın
    double divide = Random().nextDouble()+(1.2 + (pageChangeCount * 0.05) );

    int page = (SuggestParameters.pageSearchNow  / divide).ceil();

    return page;
  }

}