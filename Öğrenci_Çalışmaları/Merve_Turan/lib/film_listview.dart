import 'package:filmler/filmler.dart';
import 'package:flutter/material.dart';
import 'package:filmler/film_listview_detay.dart';
import 'package:filmler/film_listview.dart';

class FilmList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filmler'),
        ),
        body: ListView.builder(
            itemCount: filmList.length,
            itemBuilder: (context, index) {
              Filmler filmler = filmList[index];
              return Card(
                child: ListTile(
                  title: Text(filmler.baslik),
                  subtitle: Text(filmler.yapimYili.toString()),
                  leading: Image.network(filmler.resim),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FilmListDetay(filmler)));
                  },
                ),
              );
            }));
  }
}
