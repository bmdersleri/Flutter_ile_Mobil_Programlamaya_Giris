import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sut_cepte_mobile_app/screens/forget.dart';
import 'package:sut_cepte_mobile_app/screens/home.dart';
import 'package:sut_cepte_mobile_app/screens/register.dart';
import 'package:toast/toast.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return WillPopScope(
      onWillPop: () {
       return  Future.value(exit(0));

      },
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.blue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 36.0, horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giriş',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 46.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Hayvancılığın mobil dünyasına giriş yap.',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _loginTextForm(), // Giriş textformlar
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Forget()));
                                },
                                child: Text(
                                  "Şifremi Unuttum",
                                  style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          _loginButton(context), // Giriş Yapılacaka button
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "veya",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  "Kayıt Ol",
                                  style: GoogleFonts.poppins(
                                    color: Colors.indigo,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(width: 1, color: Colors.indigo),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _loginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: OutlinedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            try {
              UserCredential userCredential =
                  await _auth.signInWithEmailAndPassword(
                      email: email!, password: password!);
              User user = userCredential.user!;
              if (user.emailVerified) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              } else {
                _auth.signOut();
                showToast("Email Onaylı Değil",
                    duration: Toast.lengthLong, gravity: Toast.bottom);
              }
            } catch (e) {
              showToast("Bu email kayıtlı değil veya şifre yanlış",
                  duration: Toast.lengthLong, gravity: Toast.bottom);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Giriş Yap",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Form _loginTextForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (deger) {
                setState(() {
                  email = deger!;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Mail",
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.grey[600],
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Email Boş Kalmamalı";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              onSaved: (deger) {
                setState(() {
                  password = deger!;
                });
              },
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Şifre",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey[600],
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Şifre Boş Kalmamalı";
                } else if (value.length < 6) {
                  return "Şife en az 6 karakterli olması gerek";
                }
                return null;
              },
            ),
          ],
        ));
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
