import 'package:SuggestME/main.dart';
import 'package:flutter/material.dart';


class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.clrDark,
      ),
      backgroundColor: appColors.clrDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text("Yunus Emre Sarı \n 1911404003",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text("Mehmet Akif Ersoy Üniversitesi \n Mobil Programlamaya Giriş Dersi",style: TextStyle(height: 1.5,fontSize: 20,color: Colors.white),textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
