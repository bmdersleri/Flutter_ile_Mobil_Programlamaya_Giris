
import 'package:app1/ikinciSayfam/Kodamin%20Mohbetra.dart';
import 'package:app1/ikinciSayfam/payamadhai%20nagowar.dart';
import 'package:flutter/material.dart';

class uc extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(

        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Stack(
                children: [
                  MaterialButton(
                    onPressed: () {
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10, left: 20 ),
                    child: Text(
                      " ... پیامدهای ناگوار پیروی از تمایلات",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              trailing:Padding(
                padding: const EdgeInsets.all(5),
                child: Image(image: AssetImage('img/456.png')),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => payamadhai(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Stack(
                children: [
                  MaterialButton(
                    onPressed: () {
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10 , left: 40),
                    child: Text(
                      "کدامین محبت را برمی‌گزینی؟",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              trailing:Padding(
                padding: const EdgeInsets.all(5),
                child: Image(image: AssetImage('img/456.png')),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => kodamin(),
                  ),
                );
              },
            ),
            SizedBox(

            )

          ],
        ),
      ),
    );

  }
}