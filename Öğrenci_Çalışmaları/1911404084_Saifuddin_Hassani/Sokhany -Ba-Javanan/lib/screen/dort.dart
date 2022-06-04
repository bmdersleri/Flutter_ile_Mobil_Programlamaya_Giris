

import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/Dosthamnishin.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/Zafiman.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/bikari.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/chashumcharani.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/fikirwakhiyal.dart';


import 'package:flutter/material.dart';

class dort extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('عوامل و خاستگاه‌های بدکاری'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: 68,
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
                    padding: const EdgeInsets.only(top: 10, left: 100),
                    child: Text(
                      " ضعف ایمان ",
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
                    builder: (context) => Zafiman(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              title: Stack(
                alignment: AlignmentDirectional.topCenter,
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
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Text(
                      " دوست و هم‌نشین بد ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
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
                    builder: (context) => Dosthamnishin(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
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
                    padding: const EdgeInsets.only(top: 10, left: 70),
                    child: Text(
                      "چشم‌چرانی و نگاه آلوده ",
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
                    builder: (context) => chashum(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
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
                    padding: const EdgeInsets.only(top: 10, left: 95),
                    child: Text(
                      "بیکاری و تنهایی ",
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
                    builder: (context) => bikari(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
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
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "فکر و خیال در مورد مسایل جنسی ",
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
                    builder: (context) => fikri(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40,
            ),

          ],
        ),
      ),

    );
  }
}