import 'dart:ffi';

import 'package:kelimeuygulamasi/db/db/shared_preferences.dart';
import 'package:kelimeuygulamasi/global_variable.dart';
import 'package:kelimeuygulamasi/pages/main.dart';
import 'package:flutter/material.dart';

class TemproryPage extends StatefulWidget {
  const TemproryPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TemproryPageState createState() => _TemproryPageState();
}

class _TemproryPageState extends State<TemproryPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
    spRead();
  }

  void spRead() async {
    if (await SP.read("lang") == true) {
      chooseLang = Lang.ing;
    } else {
      chooseLang = Lang.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset("lib/images/launcher.png",
                        height: 130, width: 110),
                    Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Text(
                          "KELİME SÖZLÜĞÜM",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Luck",
                              fontSize: 40),
                        )),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Eğlenerek Öğren!",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Carter",
                          fontSize: 40),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
