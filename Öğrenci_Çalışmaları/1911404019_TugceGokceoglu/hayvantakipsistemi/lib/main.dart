import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/girissayfasi/LoginPage.dart';
import 'package:hayvantakipsistemi/girissayfasi/splashscreen.dart';
import 'package:hayvantakipsistemi/view/asilamasayfasi.dart';
import 'package:hayvantakipsistemi/view/hastaliksayfasi.dart';
import 'package:hayvantakipsistemi/view/hayvanekle.dart';
import 'package:hayvantakipsistemi/view/hayvanlarim.dart';
import 'package:hayvantakipsistemi/girissayfasi/HomePage.dart';
import 'package:hayvantakipsistemi/view/tohumlamasayfasi.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr_TR');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>SplashScreen(),
        '/anasayfa': (context) => HomePages(),
        '/girissayfasi': (context) => LoginPage(),
        '/hayvanekle': (context) => HayvanEkle(),
        '/hayvanlarim': (context) => Hayvanlarim(),
        '/asilama': (context) => AsilamaSayfasi(),
        '/hastalik': (context) => HastalikSayfasi(),
        '/tohumlama': (context) => TohumlamaSayfasi(),
      },
    );
  }
}

