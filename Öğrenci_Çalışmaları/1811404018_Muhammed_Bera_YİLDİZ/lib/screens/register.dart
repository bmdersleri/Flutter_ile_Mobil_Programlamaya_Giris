import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sut_cepte_mobile_app/screens/login.dart';
import 'package:toast/toast.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? name;
  String? email;
  String? password;
  String? againPassword;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
           
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 36.0, horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kayıt',
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
                      'Aşağıdaki bilgileri doldurarak bize katılabilirsin.',
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
              Container(
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
                      //

                      _registerForm(), // Kayıtları alınan textformfieldlerin yeri burada

                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _registerButton(context), // Kayıt butonu
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "veya",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold),
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
                                    builder: (context) => Login()));
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              "Giriş Yap",
                              style: GoogleFonts.poppins(
                                color: Colors.indigo,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 1, color: Colors.indigo),
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
            ],
          ),
        ),
      ),
    );
  }

// Kayıt etmek için tıklanan button
  Container _registerButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: OutlinedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            if (!password.toString().contains(againPassword.toString())) {
              showToast("Şifreler Aynı Değil",
                  duration: Toast.lengthLong, gravity: Toast.bottom);
              return;
            }
            try {
              UserCredential userCredential =
                  await _auth.createUserWithEmailAndPassword(
                      email: email!, password: password!);
              User user = userCredential.user!;
              if (user != null) {
                user.sendEmailVerification();
                _auth.signOut();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Login(),
                ));
              }
            } catch (e) {
              showToast("Böyle kullanıcı mevcut",
                  duration: Toast.lengthLong, gravity: Toast.bottom);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Kayıt Ol",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
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

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

// Kayıt için textformlar
  Form _registerForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (deger) {
                setState(() {
                  name = deger!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Ad Soyad",
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey[600],
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Ad ve Soyad Boş Kalmamalı";
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
                  return "Email Boş Kalınmaz";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              onSaved: (deger) {
                password = deger!;
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
                  return "Şifre Boş Kalınamaz";
                } else if (value.length < 6) {
                  return "Şifre en az 6 karakterli olması gerek";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              onSaved: (deger) {
                againPassword = deger!;
              },
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
                hintText: "Şifreyi Tekrar Giriniz",
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.grey[600],
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Şifre Boş Kalınamaz";
                } else if (value.length < 6) {
                  return "Şifre en az 6 karakterli olması gerek";
                }
                return null;
              },
            ),
          ],
        ));
  }
}
