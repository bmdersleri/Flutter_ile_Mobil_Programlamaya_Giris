import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hayvantakipsistemi/Firebase_VeriTabani/kullaniciekle/kullaniciekle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _kullaniciKaydet = false;
FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
  TextEditingController _ulkecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/inek.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    _googleilegiris(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.red,
                            Colors.yellow,
                            Colors.yellow,
                            Colors.blue,
                            Colors.green,
                          ]),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(36)),
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 50, bottom: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        height: 35,
                                        width: 35,
                                      )),
                                  Spacer(),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Text(
                                        "Google İle Giriş",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ]),
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

  Timer? _timer;
  void startTimer(String hinttext) {
    int _start = 150;
    const oneSec = const Duration(milliseconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (_start == 50) {
          _start--;
          showDialog(
            context: context,
            builder: (context) {
              return Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                    }),
                    child: Container(
                      width: 180,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF375BA3), Color(0xFF29E3D7)],
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            hinttext,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "lucida",
                              fontSize: 12,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _googleilegiris(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    GoogleSignInAccount? googleKullanici = await googleSignIn.signIn();
    if (googleKullanici != null) {
      GoogleSignInAuthentication googleKimlik =
          await googleKullanici.authentication;
      AuthCredential dogrulamaKimligi = GoogleAuthProvider.credential(
        accessToken: googleKimlik.accessToken,
        idToken: googleKimlik.idToken,
      );
      UserCredential kullaniciKimligi =
          await _auth.signInWithCredential(dogrulamaKimligi);
      User? kullanici = kullaniciKimligi.user;
      if (kullanici != null) {
        Query<Map<String, dynamic>> sorgu = FirebaseFirestore.instance
            .collection('kullanicilar')
            .where("id", isEqualTo: kullanici.uid);
        QuerySnapshot<Map<String, dynamic>> snapshot = await sorgu.get();

        if (snapshot.docs.isEmpty) {
          createUser(
            id: kullanici.uid,
            name: kullanici.displayName.toString(),
            email: kullanici.email.toString(),
          );
          if (_kullaniciKaydet == true) {
            Navigator.pushNamed(context, '/anasayfa');
          }
        } else {
          Navigator.pushNamed(context, '/anasayfa');
        }
      }
    }
  }

  Future createUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final docUser =
        FirebaseFirestore.instance.collection('kullanicilar').doc(id);
    final kullanici = KullaniciFirebase(
      id: id,
      name: name,
      email: email,
    );
    await docUser.set(kullanici.toJson());
    _kullaniciKaydet = true;
  }
}
