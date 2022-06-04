import 'package:news_app/data/news_api_client.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/news_model.dart';

class NewsRespoStory {
  NewsApiClient apiClient = getIt<NewsApiClient>();
  
  Future<List<Articles>> getTRNews() async {
    var gelenVeri = await apiClient.getTurkeyNews();
    return gelenVeri;
  }

   Future<List<Articles>> getUSNews() async {
    var gelenVeri = await apiClient.getUsNews();
    return gelenVeri;
  }
}
