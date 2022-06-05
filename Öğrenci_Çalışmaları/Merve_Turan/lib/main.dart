import 'package:filmler/film_listview.dart';
import 'package:flutter/material.dart';
import 'package:filmler/login.dart';
import 'package:filmler/register.dart';
//import 'package:filmler/sahaicerik.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'anasayfa': (context) =>  FilmList(),
        }),
  );
}
