import 'package:flutter/material.dart';
import 'package:hayvantakipsistemi/model/hayvanekle.dart';

class HayvanEkle extends StatelessWidget {
  const HayvanEkle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar:  AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF375BA3),
              size: 35,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/anasayfa');
            },
          ),
          title: Text(
            "Hayvan Ekle",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFF375BA3)),
          )),
      body: Padding(
        padding: const EdgeInsets.only(right: 16,left: 16,top: 35),
        child: Column(
          children: <Widget>[
            
            Expanded(child: HayvanEkleModal()),
          ],
        ),
      ),
    );
  }
}
