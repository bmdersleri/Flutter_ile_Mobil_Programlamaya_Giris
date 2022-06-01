import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FilterValues.dart';
import 'MovieTop.dart';
import 'MovieTitle.dart';
import 'SuggestParameters.dart';
import 'main.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
InternetConnectionChecker internetConnectionChecker = InternetConnectionChecker();

class GetDataFromAPI {
  late var titleRatings;

  String authorityWithTitleId = "moviesdatabase.p.rapidapi.com";
  // String pathWithTitleId = "/titles/tt0000002/ratings";
  Map<String, dynamic> paramsWithTitleId = {};
  Map<String, String> headersWithTitleId = {
    "x-rapidapi-key": "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
    "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
  };


  String? authority = "";
  String? path = "";
  Map<String, dynamic>? params;
  Map<String, String>? headers;

  GetDataFromAPI({this.authority,this.path,this.params,this.headers});

  //Movie Database API
  late var titlesMultiple;
  late var titlesRating;



  Future<bool> GetInternetStatus() async{

    //Timeout u 6 saniye yapıyoru ki fazla bekleme olmasın
    internetConnectionChecker.addresses = [
      AddressCheckOptions(
        InternetAddress(
          '8.8.4.4', // Google
          type: InternetAddressType.IPv6,
        ),
        port: InternetConnectionChecker.DEFAULT_PORT,
        timeout: Duration(seconds: 20),
      ),
    ];

    final bool isConnected = await internetConnectionChecker.hasConnection;

    return isConnected;
  }


  //Movie name geliyor onun sonuna trailer ekleyerek youtube da arıyoruz ve ilk çıkanın youtube id sini gönderiyoruz
  Future<String> GetTrailerFromTitleId(String movieName,String type) async {

    Map<String,dynamic> params;

    movieName = movieName.toLowerCase();
    params = {"safesearch":false.toString(),"query":""};

    if(type == "Movie")
      params["query"]= "$movieName trailer";
    else
      params["query"]= "$movieName season 1 trailer";

    print("Youtube Arama Verisi: "+ params["query"]);

    Uri uri = Uri.https(authority!,path!, params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {

      final jsonMap = json.decode(response.body);
      titlesMultiple = jsonMap;

      return jsonMap["results"][0]["id"];

    }
    else
      throw Exception('API call returned: ${response.statusCode} ${response.reasonPhrase}');
  }


  Future<String> GetImage() async {

    final bool isConnected = await InternetConnectionChecker().hasConnection;

    if(isConnected){
      print("Image Verisi Çekiliyor");
      Uri uri = Uri.https(authority!,path!,params);

      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {

        final jsonMap = json.decode(response.body);
        titlesMultiple = jsonMap;

        return (jsonMap["results"]["primaryImage"] == null) ? "no-image": jsonMap["results"]["primaryImage"]["url"].toString();
      }
      else
        throw Exception('API call returned: ${response.statusCode} ${response.reasonPhrase}');
    }else{
      return "no-internet";
    }

  }



  //Base Info ile tüm verileri çekiyoruz
  Future<MovieTitle> GetMovieInfoFromTitleId({required String titleId, String? searchingGenre}) async {

    print("Film-Dizi Verisi Çekiliyor");
    Uri uri = Uri.https(authority!,path!,params);

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {

      final jsonMap = json.decode(response.body);
      titlesMultiple = jsonMap;

      print("Title Id: "+titleId);
      late String genres;

      if(searchingGenre == "")
        genres = FilterValues.listSelectedGenres[0];
      else
        genres = searchingGenre!;

      if(jsonMap["results"]["genres"]["genres"].length != 1) genres += ", ";
      for(int i = 0;i<jsonMap["results"]["genres"]["genres"].length;i++){
        if(!genres.contains(jsonMap["results"]["genres"]["genres"][i]["text"])){
          genres += jsonMap["results"]["genres"]["genres"][i]["text"];
          if(jsonMap["results"]["genres"]["genres"].length != i+1) genres +=", ";
        }
      }

      MovieTitle movieTitle = MovieTitle(
          titleId: titleId,
          movieName: jsonMap["results"]["titleText"]["text"].toString(),
          releaseYear: jsonMap["results"]["releaseYear"]["year"].toString(),
          type: jsonMap["results"]["titleType"]["text"].toString(),
          description: (jsonMap["results"]["plot"] == null || jsonMap["results"]["plot"]["plotText"] == null) ? "No Description"
              : jsonMap["results"]["plot"]["plotText"]["plainText"].toString(),
          imdbRating: (jsonMap["results"]["ratingsSummary"]["aggregateRating"] == null) ? "--" :jsonMap["results"]["ratingsSummary"]["aggregateRating"].toString(),
          genre: genres,
      );

      return movieTitle;
      // return jsonMap["results"]["primaryImage"]["url"].toString();
    }
    else
      throw Exception('API call returned: ${response.statusCode} ${response.reasonPhrase}');
  }


  // //İç içe Future builder kullanarak veri çekiyoruz. Burası Future<MovieTitle> yerine Future<Future<MovieTitle>> döndürüyor
  // Future<Future<MovieTitle>> GetMovieInfoFromTitleId1(String titleId) async {
  //
  //   print("Film-Dizi Verisi Çekiliyor");
  //   Uri uri = Uri.https(authority!,path!,params);
  //
  //   final response = await http.get(uri, headers: headers);
  //   if (response.statusCode == 200) {
  //
  //     final jsonMap = json.decode(response.body);
  //     titlesMultiple = jsonMap;
  //
  //     MovieTitle movieTitle = MovieTitle(
  //         titleId: titleId,
  //         movieName: jsonMap["results"]["titleText"]["text"].toString(),
  //         releaseYear: jsonMap["results"]["releaseYear"]["year"].toString(),
  //         type: jsonMap["results"]["titleType"]["text"].toString());
  //
  //     return GetMovieInfoFromTitleId2(movieTitle);
  //     // return jsonMap["results"]["primaryImage"]["url"].toString();
  //   }
  //   else
  //     throw Exception('API call returned: ${response.statusCode} ${response.reasonPhrase}');
  // }
  //

  // //Burdan MDB List ile veri çekicez => description, imdb id
  // Future<MovieTitle> GetMovieInfoFromTitleId2(MovieTitle movieTitle) async {
  //
  //   print("Film-Dizi Description ve Imdb Verisi Çekiliyor");
  //   Uri uri = Uri.https(movieInfoParameters.authority!,movieInfoParameters.path!,movieInfoParameters.params);
  //
  //   final response = await http.get(uri, headers: movieInfoParameters.headers);
  //   if (response.statusCode == 200) {
  //
  //     final jsonMap = json.decode(response.body);
  //     titlesMultiple = jsonMap;
  //
  //     //GetMovieInfoFromTitleId1 den gelen movieTitle içindeki description ve imdb rating i dolduruyoruz
  //     movieTitle.description = jsonMap["description"].toString();
  //     movieTitle.imdbRating = jsonMap["ratings"][0]["value"].toString();
  //
  //     return movieTitle;
  //     // return jsonMap["results"]["primaryImage"]["url"].toString();
  //   }
  //   else
  //     throw Exception('API call returned: ${response.statusCode} ${response.reasonPhrase}');
  // }
  //




  //SuggestMe




  Future<String> SuggestMe() async {

    bool isConnected = await GetInternetStatus();

    String result = "no-result";

    if(isConnected){
      Uri uri = Uri.https(authority!,path!,params);

      int index = Random().nextInt(50);

      double imdbNow = -1;
      double minImdb = FilterValues.imdbSelectedValue!;
      if(minImdb <= 4) minImdb = 5;

      int searchCount = 0;

      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {

        final jsonMap = json.decode(response.body);
        titlesMultiple = jsonMap;

        //Page içinde veri yok page i yarı yarıya düşürmeliyiz
        if(jsonMap["results"].length == 0){
          result = "no-result";
          SuggestParameters.pageSearchNow = SuggestParameters.GetNewPage();
          return result;
        }

        if(jsonMap["results"].length <= index) {
          result = "no-result";
          print("Fazladan index: "+index.toString());
          return result;
        }

        // //Genrelerin içinde adult varsa geç
        // for(int i=0;i<jsonMap["results"][index]["genres"]["genres"].length;i++){
        //   if(jsonMap["results"][index]["genres"]["genres"][i]["text"].toString().contains("Adult")){
        //     result = "no-result";
        //     print("Adult İçeriyor");
        //     return result;
        //   }
        // }

        //Eğer min Imdb ye uygun sonuç bulamazsak 200 aramada durdur sonucu.
        //Yada 200 arama sonunda baştan sona for ile gezsin random yerine birde öyle baksın sonra boş desin.

        while((imdbNow < minImdb)){

          searchCount++;

          // print("Index geziliyor: "+index.toString());

          // print("Devamke: "+result);

          //Böyle yaparak aramanın devam etmesini sağlıyoruz.Yani eğer imdbsi yoksa devam etsin en azından imdb si olan bir title göstersin
          if(jsonMap["results"][index]["ratingsSummary"]["aggregateRating"] != null){
            imdbNow = double.parse(jsonMap["results"][index]["ratingsSummary"]["aggregateRating"].toString());
          }
          else
            imdbNow = 0;

          result = jsonMap["results"][index]["id"].toString();

          //Maksimum arama sayısına ulaşılmış
          if(searchCount >= SuggestParameters.maxSearchCount)
            break;

          //En son gösterdiğimiz title ile eşleşiyor
          if(lastTitleId == jsonMap["results"][index]["id"]){
            result = "no-result";
            print("Title IDler aynı");
            print("Yeni sayfaya geçelim o zaman.");
            if(SuggestParameters.pageSearchNow == 1) {
              print("İlk Sayfada Bile Bir Şey Bulamadık Sonlandıralım");
              SuggestParameters.pageChangeCount = SuggestParameters.maxPageChangeCount;
            }else{
              SuggestParameters.pageSearchNow -=1 ;
              print("Page Belli Bir Oranda Düşürüldü: "+SuggestParameters.pageSearchNow.toString());
            }
            break;
          }

          //Imdb kontrol
          if(imdbNow < minImdb){
            index = Random().nextInt(50);
            if(jsonMap["results"].length <= index) {
              return result;
            }
          }


        }//While


      }
      else
        result = 'API call returned: ${response.statusCode} ${response.reasonPhrase}';

      if(searchCount >= SuggestParameters.maxSearchCount){
        result = "no-result";
        print("Bu sayfadaki arama sayısı doldu. Yeni sayfaya geçmeliyiz");
        if(SuggestParameters.pageSearchNow == 1) {
          print("İlk Sayfada Bile Bir Şey Bulamadık Sonlandıralım");
          SuggestParameters.pageChangeCount = SuggestParameters.maxPageChangeCount;
        }else{
          SuggestParameters.pageSearchNow -=1 ;
          print("Page Belli Bir Oranda Düşürüldü: "+SuggestParameters.pageSearchNow.toString());
        }
      }

    }
    else{
      result = "no-internet";
    }


    return result;


  }


  //Prefs e kaydedilmiş olan last title Id yi alıyoruz
  Future<String> GetLastTitle() async {

    final SharedPreferences prefs = await _prefs;

    String strTurn;

    if (prefs.getString("lastTitleId") == null) {
      print("LastTitleId null çekti: " + lastTitleId);
      strTurn = "no-title";
    }
    else {

      bool isConnected = await GetInternetStatus();

      if(isConnected){
        strTurn = prefs.getString("lastTitleId")!;
        lastSearchingGenre = prefs.getString("lastSearchingGenre");
      }
      else
        strTurn = "no-internet";

    }

    return strTurn;

  }

  Future<String> InternetControl() async {

    String strTurn;
    bool isConnected = await GetInternetStatus();

    if(isConnected)
      strTurn = "success";
    else
      strTurn = "no-internet";

    return strTurn;

  }




}



