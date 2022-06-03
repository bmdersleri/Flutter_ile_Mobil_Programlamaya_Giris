import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kadojopapp/components/components.dart';
import 'package:kadojopapp/screens/login.dart';

import '../../Model/shar.dart';

class Information extends StatelessWidget {
  var emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  const Text(
          "Information",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        titleSpacing: 25,
        backgroundColor: TextColors,
      ),
      body: Column(
         children: [
           Padding(
             padding: const EdgeInsets.only(
               top: 50,
               left: 10
             ),
             child: Container(

               width: double.infinity,
               child: Text('Email : ${user.email}',style: const TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold
               ),),
             ),
           ),
         ],
      )
    );
  }
}
