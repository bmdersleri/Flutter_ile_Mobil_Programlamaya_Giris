import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class comminication extends StatelessWidget {
  const comminication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communication'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.mail,
              ),
              title: const Text('ahmetkocatepebm@gmail.com',style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'AbrilFatface'),),
            ),
            ListTile(
              leading: Icon(
                Icons.facebook,
              ),
              title: const Text('Ahmet KOCATEPE',style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'AbrilFatface'),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone_android,
              ),
              title: const Text('+90 534 381 70 89',style: TextStyle(
                  color: Colors.white, fontSize: 15, fontFamily: 'AbrilFatface'),),
            ),
            ListTile(
              title: Align(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('It is designed to learn the most up-to-date weather conditions on the agenda.',style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'AbrilFatface'),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Align(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('You can report your suggestions and complaints through Communication ways.',style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'AbrilFatface'),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Align(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Text('Powered by Ahmet KOCATEPE',style: TextStyle(
                      color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}