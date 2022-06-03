import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kadojopapp/Model/shar.dart';
import 'package:kadojopapp/components/components.dart';
import 'package:kadojopapp/screens/login.dart';
import 'package:kadojopapp/screens/setting/info.dart';

import 'aboutapp.dart';

class Setting extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: TextStyle(
            color: Color(0xFF285681),
          ),
        ),
        titleSpacing: 25,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
                child: Icon(Icons.settings, size: 100),
              ),
              spec,
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ExpansionTile(
                      textColor: TextColors,
                      collapsedBackgroundColor: TextColors,
                      iconColor: TextColors,
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      backgroundColor: Colors.white10,
                      title: const Center(
                          child: Text(
                        'See Your Information',
                        style: TextStyle(fontWeight: FontWeight.bold
                            //color: Colors.black,
                            ),
                      )),
                      children: [
                        Text(
                          'Email : ${user.email}',
                          style:const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 500,
                    height: 50,
                    child: defoultButtun(
                      text: 'About',
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutApp()));
                      }, ), ), ], ),
              const   SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print('signed out');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
