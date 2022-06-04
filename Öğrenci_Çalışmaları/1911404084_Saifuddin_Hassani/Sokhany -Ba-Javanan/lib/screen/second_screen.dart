
import 'package:app1/ikinciSayfam/first.dart';
import 'package:app1/ikinciSayfam/fur.dart';
import 'package:app1/ikinciSayfam/second.dart';
import 'package:app1/ikinciSayfam/thirt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class second_screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('نتایج عفت پاکدامنی')
          ],
        ),
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
                    padding: const EdgeInsets.only(top: 10, left: 52),
                    child: Text(
                      " رستگاری و ثنا و تعریف الهی ",
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
                    builder: (context) => first(),
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
                    padding: const EdgeInsets.only(top: 10, left: 0),
                    child: Text(
                      "... ماندگاری پاکدامنان در بهشت و ",
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
                    builder: (context) => second(),
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
                    padding: const EdgeInsets.only(top: 10, left: 75),
                    child: Text(
                      "آرامش و آسودگی خاطر ",
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
                    builder: (context) => thirt(),
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
                    padding: const EdgeInsets.only(top: 15, left: 90),
                    child: Text(
                      "لذت غلبه بر نفس ",
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
                    builder: (context) => fur(),
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