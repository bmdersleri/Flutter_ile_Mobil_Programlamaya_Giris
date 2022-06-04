import 'package:flutter/material.dart';
import 'package:vetlogin/widget/collection_items.dart';

class Profil extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(  appBar: AppBar(title: Text('Hakkımızda'),), //Scaffold sınıfnın içinden appbar özelliğini barındırır.
      body: Container( decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
        child: Column( 
          children: [
            Column(
              children: [
                CircleAvatar(//Görüntü, daire şeklinde olacak şekilde kırpılacaktır.

                                  backgroundColor: Colors.white,
                                  radius: 130.0,
                                  child: CircleAvatar(
                                    backgroundImage:   NetworkImage('https://uyg-ar.com/assets/img/team/team-7_600x600.jpg'),//Bağlantı vererek resmi görüntüleyebiliyoruz.
                                    radius: 125.0,
                                  ),
                                ),

                Center(child: Text("Esra Arslan  E-mail : arslanesratr@gmail.com", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color:Colors.white),)),
              ],
            ),
            Column(
          children: [
            CircleAvatar(
                              backgroundColor: Colors.white, // arka planı belirlemekteyiz.
                              radius: 130.0,
                              child: CircleAvatar(
                                backgroundImage:   NetworkImage('https://uyg-ar.com/assets/img/team/team-6_600x600.jpg',),//Bağlantı vererek resmi görüntüleyebiliyoruz.
                                radius: 125.0,
                              ),
                            ),

            Center(child: Text("Derya Ayyıldız / E-mail : ayyildizderya34@gmail.com",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,color:Colors.white) ,))
          ],
        )
          ],
        ),
      )
    );
  }

}