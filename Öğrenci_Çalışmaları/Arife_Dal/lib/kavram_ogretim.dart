import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MobileApp());

class MobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Özel Eğitim",
      home: KavramOgretim(),
    );
  }
}

class KavramOgretim extends StatefulWidget {
  @override
  _KavramOgretimState createState() => _KavramOgretimState();
}

class ItemModel {
  final String dersAd;

  ItemModel(this.dersAd);
}

class _KavramOgretimState extends State<KavramOgretim> {
  final Color accentColor = Colors.green;

  List<ItemModel> items = [
    ItemModel("Kavram Öğretimi"),
    ItemModel("Tam-Yarım-Çeyrek"),
    ItemModel("Mevsimler"),
    ItemModel("Trafik"),
    ItemModel("Çöp Adam"),
    ItemModel("Az-Çok"),
    ItemModel("Benzer Farklı"),
    ItemModel("Büyük-Küçük"),
    ItemModel("Kelime Treni"),
    ItemModel("Eşle-Oyna"),
    ItemModel("Dil Becerileri"),
    ItemModel("Sayı Eşleşme Oyunu"),
    ItemModel("Boncuk Dizmece"),
    ItemModel("5 Duyumuz"),
    ItemModel("5 Duyumuz Ekinlik"),
    ItemModel("Varlıkların Sayılarına Göre İsimleri"),
    ItemModel("Bilmeceler"),
    ItemModel("Okul Eşyaları"),
    ItemModel("İşaretlerine Bakalım"),
    ItemModel("Çantam"),
    ItemModel("Yazı Bulmaca (Aile)"),
    ItemModel("Dikkat ve Algı Geliştirici Oyunlar")
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget _buildTitle() {
    return Text(
      "Kavram Öğretimi",
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Text _buildText(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  IconButton _buildButton(IconData icon) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBottomCardChildren() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 24,
        ),
      ],
    );
  }

  Widget _buildBottomCard(double width, double height) {
    return Container(
      width: width,
      height: height / 3,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16))),
      child: _buildBottomCardChildren(),
    );
  }

  Widget _buildItemCardChild(ItemModel item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              item.dersAd,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                String url1 =
                    "https://erisilebilirizmir.org/kavram-13/story_html5.html";
                launch(url1);
              },
              icon: Icon(
                Icons.menu_open,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildItemCard(ItemModel item) {
    return Container(
      width: 90,
      height: 80,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      margin: EdgeInsets.only(left: 20, right: 20, top: 2, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 17, 42, 18), blurRadius: 10)
          ]),
      child: _buildItemCardChild(item),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 30),
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items.elementAt(index);
        return _buildItemCard(item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: _buildTitle(),
        actions: <Widget>[],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCard(width, height)),
            _buildCardsList(),
          ],
        ),
      ),
    );
  }
}
