import 'package:flutter/material.dart';
import 'package:kadojopapp/screens/contact.dart';
import 'package:kadojopapp/screens/homePage.dart';
import 'package:kadojopapp/screens/login.dart';
import 'package:kadojopapp/screens/projectscreen.dart';
import 'package:kadojopapp/screens/recister.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: Login(),
    );
  }
}
