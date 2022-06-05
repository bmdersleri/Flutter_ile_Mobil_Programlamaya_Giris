import 'package:flutter/material.dart';
import 'package:filmler/filmler.dart';

class FilmListDetay extends StatelessWidget {

  final Filmler filmler;

  FilmListDetay(this.filmler);





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filmler.baslik),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                filmler.resim,
                height: 500,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  filmler.yapimYili.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  filmler.filmAciklama,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
