import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Articles> searchTr;

  CustomSearchDelegate({required this.searchTr});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query.isEmpty ? null : "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.arrow_back_ios),
      onTap: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var filter = searchTr
        .where((element) =>
            element.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return filter.isNotEmpty
        ? ListView.builder(
            itemCount: filter.length,
            itemBuilder: (context, index) {
              var gelenNews = filter[index];
              return Padding(
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
              );
            },
          )
        : Center(
            child: Text("Aradığınız veri bulunamadı"),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  _lanuchUrl(String? url) async {
    try {
      await launch(url!, forceWebView: true);
    } catch (e) {}
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

  Padding newsTitleMetod(Articles gelenNews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(gelenNews.title.toString()),
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

 @override
  String get searchFieldLabel => 'Haber Ara';

}
