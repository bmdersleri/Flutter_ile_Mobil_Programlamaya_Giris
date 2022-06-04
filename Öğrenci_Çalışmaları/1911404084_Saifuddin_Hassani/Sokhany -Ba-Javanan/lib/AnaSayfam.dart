
import 'dart:io';
import 'package:app1/screen/about.dart';
import 'package:app1/screen/alti.dart';
import 'package:app1/screen/bes.dart';
import 'package:app1/screen/dort.dart';
import 'package:app1/screen/first_screen.dart';
import 'package:app1/screen/second_screen.dart';
import 'package:app1/screen/uc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class AnaSayfam extends StatefulWidget {
  @override
  AnaSayfamState createState() => AnaSayfamState();
}

class AnaSayfamState extends State<AnaSayfam> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'سخنی با جوانان',
                ),
              ],
            ),
          ),
          backgroundColor: Colors.teal,
        ),

        endDrawer: Container(
          width: 230,
          child: Drawer(
              child: Column(children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.teal[900],
                      gradient: LinearGradient(
                          colors: <Color>[Colors.teal, Colors.tealAccent]),
                    ),
                    child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          bottom: 1,

                        ),
                        child: Image(
                          width: double.infinity,
                          image: AssetImage('img/7.jpg'),
                        ))),
                SizedBox(
                  height: 2,
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) =>about()));

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(' Hakında  در باره برنامه'),
                      SizedBox(width: 12),
                      Icon(Icons.info_outline),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context ){
                            return AlertDialog(
                              title: Text('خروج برنامه'),
                              content: Text('آیا قصد خروج از برنامه را دارید؟'),
                              actions: [
                                TextButton(
                                  child: Text('خیر'),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                    child: Text('بله'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      exit(0);
                                    }
                                )
                              ],

                            );
                          });


                    }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('خروج',style: TextStyle(
                        color: Colors.black87
                    ),),
                    SizedBox(width: 25),
                    Icon(Icons.power_settings_new,color: Colors.black87),
                    SizedBox(
                      width: 8,

                    ),
                  ],
                ))



              ],
              )
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.only(
            top: 1,
          ),

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
                      padding: const EdgeInsets.only(top: 10, left: 112),
                      child: Text(
                        "سخن آغازین ",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FirstScreen(),
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
                        "نتایج عفت و پاکدامنی ",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => second_screen(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                title: Stack(
                  children: [
                    MaterialButton(
                      onPressed: () {
                      },
                      child: Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        "پیامدهای ناگوار پیروی از تمایلات جنسی ",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => uc(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
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
                        "عوامل و خاستگاه های بدکاری ",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dort(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
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
                        " رهایی از تصورات و خیالهای جنسی",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => bes(),
                    ),
                  );

                },
              ),
              SizedBox(
                height: 50,
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
                      padding: const EdgeInsets.only(top: 10, left: 120),
                      child: Text(
                        "چند هشدار ",
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
                  child:Image(image: AssetImage('img/123.png')),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => alti(),
                    ),
                  );
                },
              ),

            ],
          ),
        ));
  }


}

