import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Scaffold(
          backgroundColor: Color(0xffFFC803),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            toolbarHeight: 120,
            elevation: 0,
            backgroundColor: Color(0xffFFC803),
            centerTitle: true,
            title:
                SizedBox(width: 140, child: Image.asset('lib/assets/logo.png')),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(48.0),
              child: Image.asset('lib/assets/abouttext.png'),
            ),
          )),
    ));
  }
}
