import 'package:flutter/material.dart';

class TrafficSigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          "Trafik İşaretleri",
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(50),
              child: Column(
                
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  
                  children: [
                   
            Positioned.fill(
              child:
                  Image.asset('assets/images/images01.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child:
                  Image.asset('assets/images/images02.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child:
                  Image.asset('assets/images/images03.jpg', fit: BoxFit.cover),
            ),
            Positioned.fill(
              child:
                  Image.asset('assets/images/images04.jpg', fit: BoxFit.cover),
            ),
          ]))),
    ));
  }
}
