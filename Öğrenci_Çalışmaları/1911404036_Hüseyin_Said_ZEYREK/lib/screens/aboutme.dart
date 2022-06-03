import 'package:flutter/material.dart';

class aboutMe extends StatelessWidget {
  const aboutMe();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelime Ekleme Ekrani"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 150, bottom: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Ad Soyad: ", style: TextStyle(
                    fontSize: 20,
                  )),
                  Text("Hüseyin Said Zeyrek", style: TextStyle(
                    fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("E-posta: ", style: TextStyle(
                    fontSize: 20,
                  )),
                  Text("huseyinsaidzeyrek@gmail.com",style: TextStyle(
                    fontSize: 20,
                  ))
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Okul: ", style: TextStyle(
                  fontSize: 20,
                )),
                Text("Mehmet Akif Ersoy Üniversitesi",style: TextStyle(
                  fontSize: 20,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}