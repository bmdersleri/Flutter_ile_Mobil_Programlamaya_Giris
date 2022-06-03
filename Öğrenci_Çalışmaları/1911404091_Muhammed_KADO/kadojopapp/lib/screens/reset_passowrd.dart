import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadojopapp/screens/homePage.dart';
import '../Model/shar.dart';
import '../components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reset extends StatefulWidget {
  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  var emailController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reset Password',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spec,
                  spec,
                  defoutformfield(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Email must not empty";
                        }
                        return null;
                      },
                      lebel: 'Email',
                      icon: const Icon(Icons.email),
                      controller: emailController,
                      keybord: TextInputType.emailAddress),
                  spec,
                  defoultButtun(
                      text: 'Reset Password',
                      function: () {
                        FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) => Navigator.of(context).pop());
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
