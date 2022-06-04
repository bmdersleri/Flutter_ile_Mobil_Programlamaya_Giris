import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';

class NewsApiClient {
  final http.Client httpClient = http.Client();
  // https://newsapi.org/v2/top-headlines?country=tr&apiKey=bb65ff85ca75461795102a37d1811405

  List<Articles> trArticles = [];
  List<Articles> usArticles = [];

  Future<List<Articles>> getTurkeyNews() async {
    Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=tr&apiKey=bb65ff85ca75461795102a37d1811405");
    var response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Veri Gelmedi");
    }
    var gelenVeri = jsonDecode(response.body)["articles"] as List;
    gelenVeri.forEach((element) {
      var artic = Articles.fromJson(element);
      trArticles.add(artic);
    });
    return trArticles;
  }

  Future<List<Articles>> getUsNews() async {
    Uri uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=bb65ff85ca75461795102a37d1811405");
    var response = await httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Veri Gelmedi");
    }
   
    var gelenVeri = jsonDecode(response.body)["articles"] as List;
    gelenVeri.forEach((element) {
      var artic = Articles.fromJson(element);
      usArticles.add(artic);
    });
    return usArticles;



  }
}
