import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadojopapp/screens/homePage.dart';
import 'package:kadojopapp/screens/login.dart';

import '../Model/shar.dart';
import '../components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Recister extends StatefulWidget {
  @override
  State<Recister> createState() => _RecisterState();
}

class _RecisterState extends State<Recister> {
  final _auth = FirebaseAuth.instance;
  var nameControlar = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var BirthdayController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text(
          'Recister',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30),
        ),
        backgroundColor: TextColors,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spec,
                  defoutformfield(
                    validator:(value)
                    {
                      if (value.isEmpty){
                        return "FullName must not empty";
                      }
                      return null;
                    },
                    lebel: 'FullName',
                    icon: Icon(Icons.account_circle_rounded),
                    controller: nameControlar,
                  ),
                  spec,
                  defoutformfield(
                      validator:(value)
                      {
                        if (value.isEmpty){
                          return "Email must not empty";
                        }
                        return null;
                      },
                      lebel: 'Email',
                      icon: const Icon(Icons.email),
                      controller: emailController,
                      keybord: TextInputType.emailAddress),
                  spec,
                  defoutformfield(
                      validator:(value)
                      {
                        if (value.isEmpty){
                          return "New Password must not empty";
                        }
                        return null;
                      },
                      lebel: 'New Password',
                      obscureText: true,
                      icon: const Icon(Icons.lock),
                      controller: passController,
                      keybord: TextInputType.visiblePassword),
                  spec,
                  defoutformfield(
                      validator:(value)
                      {
                        if (value.isEmpty){
                          return "Your age must not empty";
                        }
                        return null;
                      },
                      lebel: 'Your age',
                      controller: BirthdayController,
                      icon: const Icon(Icons.calendar_month),
                      keybord: TextInputType.visiblePassword),
                  spec,
                  defoultButtun(
                    text: 'Recister now',
                    function: () async {


                        final user = await _auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passController.text).then((value)
                        {
                          print('Create New Accaount');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

                        }).onError((error, stackTrace)
                        {
                          print('error${error.toString()
                          }');});

                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
