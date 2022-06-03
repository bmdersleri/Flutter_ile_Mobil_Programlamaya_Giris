import 'package:flutter/cupertino.dart';
import 'package:news_app/data/news_respostory.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/news_model.dart';

enum NewsCheck {
  InitialNewsState,
  NewsLoadingState,
  NewsLoadedState,
  NewsErrorState,
}

class NewsViewModel extends ChangeNotifier {
  late NewsCheck _state;
  NewsRespoStory newsRepo = getIt<NewsRespoStory>();
  List<Articles> trArticles = [];
  List<Articles> usArticles = [];

  late News gelenUsNews;

  NewsViewModel() {
    _state = NewsCheck.InitialNewsState;
  }

  get state => this._state;
  set state(value) {
    this._state = value;
    notifyListeners();
  }

  Future<List<Articles>> getTurkeyyNews() async {
    try {
      state = NewsCheck.NewsLoadingState;
      trArticles = await newsRepo.getTRNews();
      state = NewsCheck.NewsLoadedState;
    } catch (e) {
      state = NewsCheck.NewsErrorState;
    }
    return trArticles;
  }

  Future<List<Articles>> getUsNews() async {
    try {
      state = NewsCheck.NewsLoadingState;
      usArticles = await newsRepo.getUSNews();
      state = NewsCheck.NewsLoadedState;
    } catch (e) {
      state = NewsCheck.NewsErrorState;
    }
    return usArticles;
  }
}
