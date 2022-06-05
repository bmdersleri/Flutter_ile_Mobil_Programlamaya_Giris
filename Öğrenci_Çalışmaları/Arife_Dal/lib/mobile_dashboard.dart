import 'package:deneme1/hakkinda.dart';
import 'package:deneme1/kavramText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'kavram_ogretim.dart';

void main() => runApp(MobileApp());

class MobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Özel Eğitim",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class ItemModel {
  final String dersAd;
  final int dersSayi;

  ItemModel(this.dersAd, this.dersSayi);
}

class _HomePageState extends State<HomePage> {
  final Color accentColor = Colors.green;

  static List<ItemModel> items = [
    ItemModel("Kavram Öğretimi", 22),
    ItemModel("Okuma ve Yazma", 23),
    ItemModel("Matematik", 23),
    ItemModel("Dil ve İletişim", 22),
    ItemModel("Günlük Beceriler", 21),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  Widget _buildTitle() {
    return Text(
      "Özel Eğitim",
      style: TextStyle(
          fontSize: 40, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Text _buildText(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBottomCard(double width, double height) {
    return Container(
      width: width,
      height: height / 2,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(28), topLeft: Radius.circular(28))),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => KavramText()));
              },
              icon: Icon(
                Icons.menu_book_rounded,
              ),
              color: accentColor,
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => KavramOgretim()));
              },
              icon: Icon(
                Icons.menu,
                color: Colors.grey,
              ),
            ),
            Text(
              item.dersSayi.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemCard(ItemModel item) {
    return Container(
      width: 100,
      height: 120,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(left: 32, right: 32, top: 4, bottom: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(28)),
          boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 39, 96, 41), blurRadius: 10)
          ]),
      child: _buildItemCardChild(item),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
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
        backgroundColor: Colors.grey[300],
        title: _buildTitle(),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => About()));
            },
            icon: Icon(
              Icons.article,
              color: Colors.blueGrey,
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16),
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
