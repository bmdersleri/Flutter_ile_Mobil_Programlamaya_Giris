import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/viewmodel/favorite_tr.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:news_app/widgets/fav_add_icon.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TurkeyNews extends StatefulWidget {
  BuildContext context;
  TurkeyNews({required this.context, Key? key}) : super(key: key);

  @override
  State<TurkeyNews> createState() => _TurkeyNewsState();
}

class _TurkeyNewsState extends State<TurkeyNews> {
  late NewsViewModel _newsViewModel;
  late FavTrViewModel _favTrViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _newsViewModel = Provider.of<NewsViewModel>(context);
    _favTrViewModel = Provider.of<FavTrViewModel>(context);
    return _newsViewModel.state == NewsCheck.NewsLoadedState
        ? gelenList(context)
        : _newsViewModel.state == NewsCheck.NewsLoadingState
            ? newsGetiriliyor()
            : _newsViewModel == NewsCheck.NewsErrorState
                ? newsHata()
                : Center(
                    child: Text("No Data"),
                  );
  }

  Widget gelenList(BuildContext context) {
    var trNews = _newsViewModel.trArticles;
    _favTrViewModel.add(trNews);
    return ListView.builder(
      itemCount: trNews.length,
      itemBuilder: (context, index) {
        var gelenNews = trNews[index];
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => _lanuchUrl(gelenNews.url),
                child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        newsImageBlog(context, gelenNews),
                        newsTitleMetod(gelenNews),
                        newsContentMetod(gelenNews),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    )),
              ),
            ),

            /*
            // Favori ekleme butonu
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: UserFavAdd(
                    isFav: _favTrViewModel.getisFav(
                        index), // Kaydededilen veriyi buraya veri tabanından çekiceğiz
                    favClick: () {
                      debugPrint("Tıklandı: " + index.toString());
                      bool a = !_favTrViewModel.getisFav(index);
                      _favTrViewModel.update(index, a);
                      // Veri tabanına kaydedip bunu  ve gelen verileri ona göre işlem yapıcağız.

                      // Firebase favoriler kısmına eklenecek veri buraya yazılacak.
                    },
                  ),
                )),

*/
          ],
        );
      },
    );
  }

  Padding newsContentMetod(Articles gelenNews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: gelenNews.content.toString() != null
          ? Text(
              gelenNews.content.toString() != "null"
                  ? gelenNews.content.toString()
                  : "",
              style: TextStyle(color: Colors.grey),
            )
          : Text(""),
    );
  }

  Padding newsTitleMetod(Articles gelenNews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(gelenNews.title.toString()),
    );
  }

  Stack newsImageBlog(BuildContext context, Articles gelenNews) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Image.network(
            gelenNews.urlToImage.toString(),
            fit: BoxFit.cover,
            errorBuilder: (context,object,stactree){
              return Center(child: Text("Resim indirilemedi"),);
            },
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Chip(label: Text(gelenNews.author.toString()))),
        ),
        Positioned(
          bottom: 1,
          child: Align(
              alignment: Alignment.bottomRight,
              child: Chip(
                  label: Text(DateFormat.yMEd('tr_TR').format(
                      DateTime.parse(gelenNews.publishedAt.toString()))))),
        ),
      ],
    );
  }

  newsGetiriliyor() {
    return Center(child: CircularProgressIndicator());
  }

  newsHata() {
    return Center(
      child: Text("Veride Hata "),
    );
  }

  _lanuchUrl(String? url) async {
    try {
      await launch(url!, forceWebView: true);
    } catch (e) {}
  }
}
