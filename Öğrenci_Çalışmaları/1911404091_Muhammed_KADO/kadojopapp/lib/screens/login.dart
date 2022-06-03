import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kadojopapp/Model/shar.dart';
import 'package:kadojopapp/screens/recister.dart';
import 'package:kadojopapp/screens/reset_passowrd.dart';

import '../components/components.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'asset/img/logo2.png',
                    height: 200,
                  ),
                  defoutformfield(
                      validator: () {},
                      lebel: 'Email',
                      icon: const Icon(Icons.email),
                      controller: emailController,
                      keybord: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  defoutformfield(
                      validator: (value) {},
                      lebel: ' Password',
                      icon: const Icon(Icons.lock),
                      obscureText: true,
                      controller: passController,
                      keybord: TextInputType.visiblePassword),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Reset()));
                            });
                          },
                          child: const Text(
                            'Forget Password?',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  defoultButtun(
                    text: 'LOGIN',
                    function: () {
                      print('logIn done');
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passController.text)
                          .then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print('Error${error.toString()}');
                      });
                    },
                  ),
                  spec,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I Don\'t Have Account',
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Recister()));
                            });
                          },
                          child: const Text(
                            'Register Now',
                          )),
                    ],
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
