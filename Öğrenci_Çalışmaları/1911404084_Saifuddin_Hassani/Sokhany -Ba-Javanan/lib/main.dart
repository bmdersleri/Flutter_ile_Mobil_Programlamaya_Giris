
import 'package:app1/AnaSayfam.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp()));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AnaSayfam()));
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image:  AssetImage("img/7.jpg"),
                fit: BoxFit.fitWidth)),
      ),
    );
  }
}