import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggy/Corbalar.dart';
import 'package:veggy/anaYemekler.dart';
import 'package:veggy/aperatifYemek.dart';
import 'package:veggy/app_Hakkinda.dart';
import 'package:veggy/homepage.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //cihaza göre expand olması icin yazılır.
        child: Drawer(
          child: ListView(
            itemExtent: 100,
            // padding: EdgeInsets.only(top: 20),
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topLeft,
                          image: AssetImage('images/hamburger.png'),
                          fit: BoxFit.contain)),
                  child: IconButton(
                      alignment: Alignment.topRight,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close_rounded)),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 149, 199, 151),
                    border: Border(
                        top: BorderSide(
                            width: 0.8,
                            color: Color.fromARGB(255, 93, 93, 93)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile( //Liste olarak görünmesi icin navigasyonların, kullanılır.
                    title: Text(
                      'Ana Sayfa',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 149, 199, 151),
                    border: Border(
                        top: BorderSide(
                            width: 0.8,
                            color: Color.fromARGB(255, 93, 93, 93)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      'Corbalar',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Corbalar()));
                    },
                  ),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 149, 199, 151),
                    border: Border(
                        top: BorderSide(
                            width: 0.8,
                            color: Color.fromARGB(255, 93, 93, 93)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      'Aperatifler',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AperatifYemekler()));
                    },
                  ),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 149, 199, 151),
                    border: Border(
                        top: BorderSide(
                            width: 0.8,
                            color: Color.fromARGB(255, 93, 93, 93)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      'Ana Yemekler',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnaYemekler()));
                    },
                  ),
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 149, 199, 151),
                    border: Border(
                        top: BorderSide(
                            width: 0.8,
                            color: Color.fromARGB(255, 93, 93, 93)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Text(
                      'Uygulama Hakkında',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HakkindaPage()));
                    },
                  ),
                ),
              ),

              // ListTileElemanlari(ListTileName: 'Aperatifler'),
              // ListTileElemanlari(ListTileName: 'Ana Yemekler'),
              // ListTileElemanlari(ListTileName: 'Uygulama Hakkında'),
              Container(
                color: Colors.white,
              ),
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/hamburger.png'),
                            fit: BoxFit.contain)),
                  ),
                  Center(
                    child: Text(
                      'Afiyet Olsun',
                      style: GoogleFonts.inter(
                          textStyle:
                              TextStyle(color: Colors.green, fontSize: 20)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListTileElemanlari extends StatelessWidget {
  ListTileElemanlari({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 149, 199, 151),
          border: Border(
              top: BorderSide(
                  width: 0.8, color: Color.fromARGB(255, 93, 93, 93)))),
      child: Container(
        alignment: Alignment.centerLeft,
        child: ListTile(
          title: Text(
            'Ana Sayfa',
            style: GoogleFonts.inter(
                textStyle:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => homePageBody()));
          },
        ),
      ),
    );
  }
}
