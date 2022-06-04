
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/Rahnamod%20rasollullah.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/Roza.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/chashumaznigah.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/dua.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/naomidmabash.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/parhiz.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/quwatiman.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/yadawari.dart';
import 'package:flutter/material.dart';

import '../ikinciSayfam/ucuncuSayfam/dortuncuSayfam/peshgiri qblaz darman.dart';

class bes extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('راه‌های رهایی از تصورات و خیال‌های جنسی'),
        backgroundColor: Colors.teal,
      ),

      body: Container(

        child: ListView(
          children: [

            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 110),
                    child: Text(
                      " قوت ایمان ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => quwat(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 1),
                    child: Text(
                      " پیش‌گیری قبل از درمان ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => peshgiri(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 60),
                    child: Text(
                      "رهنمود رسول الله صلی الله 	",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => Rahnamod(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 15, left: 130),
                    child: Text(
                      "روزه ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => Roza(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 80),
                    child: Text(
                      "پرهیز از سهل‌انگاری ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => parhiz(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                      "چشم از نیکان برنگردان ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => chashumaznigah(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 85),
                    child: Text(
                      "دعا، اسلحه‌ی مؤمن	 ",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => dua(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 60),
                    child: Text(
                      "یادآوری نعمت‌های بهشت	",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => yadawari(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
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
                    padding: const EdgeInsets.only(top: 10, left: 110),
                    child: Text(
                      "ناامید مباش	",
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 16,
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
                    builder: (context) => naomid(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),

      ),

    );
  }
}