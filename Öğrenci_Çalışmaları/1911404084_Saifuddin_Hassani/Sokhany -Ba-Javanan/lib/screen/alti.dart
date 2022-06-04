
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/barmola.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/charai.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/darsi.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/khwarshudan.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/kinar.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/qaiq.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/sukhani.dart';
import 'package:app1/ikinciSayfam/ucuncuSayfam/dortuncuSayfam/besinciSayafam/altinciSayafam/taslimshudan.dart';
import 'package:flutter/material.dart';

class alti extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('چند هشدار'),
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
                    padding: const EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "... تسلیم‌شدن در برابر فشار و  ",
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
                    builder: (context) => taslim(),
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
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    child: Text(
                      " برملاکردن راز خود ",
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
                    builder: (context) => barmola(),
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
                    padding: const EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "خوارشدن یا ناچیزدانستن گناه 	",
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
                    builder: (context) => khwarshudan(),
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
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "... کناره‌گیری از بندگان نیک و شایسته‌",
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
                    builder: (context) => kinar(),
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
                      "چاره‌ای جز مجاهدت نیست",
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
                    builder: (context) => charai()),
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
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Text(
                      "درسی در زمینه‌ی عفت و پاک‌دامنی",
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
                    builder: (context) => darsi(),
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
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "...قایق‌های نجات یوسف (ع) از امواج",
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
                    builder: (context) => qaiq(),
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
                    padding: const EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "سخنی با اولیا و مربیان محترم	",
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
                    builder: (context) => sukhani(),
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