import 'package:flutter/cupertino.dart';
import 'package:news_app/model/news_model.dart';

class FavTrViewModel extends ChangeNotifier {
 
  List<bool> isFavorite = [];

  add(List<Articles> as) {
    for (int i = 0; i < as.length; i++) {
      isFavorite.add(false);
    }
  }

  update(int index, bool a) {
    isFavorite[index] = a;
    notifyListeners();
  }

  getisFav(int index) {
    return isFavorite.elementAt(index);
  }
}