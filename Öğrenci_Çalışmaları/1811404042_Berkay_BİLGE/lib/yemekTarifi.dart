import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endDraweMenu.dart';

class YemekTarifi extends StatelessWidget {
  String yemekAd;
  String yemekImage;
  String yemekTarif;
  String yemekMalzeme;
  YemekTarifi(
      {Key? key,
      required this.yemekAd,
      required this.yemekImage,
      required this.yemekTarif,
      required this.yemekMalzeme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Appbarı yeni sayfa icin tekrar oluşturuyoruz.
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset('images/hamburger.png',
            fit: BoxFit.contain,
            width: 65,
            height: 35,
            alignment: Alignment.topLeft),
      ),
      endDrawer: DrawerMenu(),
      body: ListView( //Sayfanın aşağı doğru sıralanması için bu sefer ListView kullanılır.
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row( //İmaj ve textlerin yerini belirlemek yani soldan saga.
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/$yemekImage.png'),
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tarif',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                          color: Colors.purple,
                          fontSize: 15,
                        )),
                      ),
                    ),
                    Text(
                      yemekAd,
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.all(16),
            child: Text(
              'Malzemeler', //List view içinde donduruyoruz. Cunku asagı sıralansın.
              style: GoogleFonts.inter(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            alignment: Alignment.topLeft,
            child: Text(
              yemekMalzeme, //Yemek malzemelerini çekiyoruz.
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 105, 105, 105))),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Nasıl Yapılır?',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(
                    yemekTarif, //Yemeğin tarifi gelir.
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 105, 105, 105))),
                  ),
                ),
              ],
            ),
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
                  'Afiyet Olsun!',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
