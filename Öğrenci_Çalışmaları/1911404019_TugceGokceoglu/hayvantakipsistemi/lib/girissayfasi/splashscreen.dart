import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

const _colorizeColors = [
  Color(0xFF375BA3),
  Color(0xFF29E3D7),
  Color.fromARGB(255, 73, 114, 197),
  Color(0xFF29E3D7),
];

class _SplashScreenState extends State<SplashScreen> {
  
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    startTimer();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/haytek.png',
                  color:Color(0xFF375BA3),
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 15,),
                AnimatedTextKit(
                  isRepeatingAnimation: true,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'HAYTEK',
                       speed: Duration(seconds: 1),
                      textStyle: TextStyle(fontSize: 60),
                      colors: _colorizeColors,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _yonlendir(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      User? kullanici = _auth.currentUser;
      if (kullanici != null) {
        Timer(Duration(seconds: 1),
            () => Navigator.pushNamed(context, '/anasayfa'));
      } else {
        Timer(Duration(seconds: 1),
            () => Navigator.pushNamed(context, '/girissayfasi',));
      }
    });
  }
  Timer? _timer;
    void startTimer() {
    int _start = 1;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 ) {
          timer.cancel();
          dispose();
          _yonlendir(context);
        
        } else {
          _start--;

        }
      },
    );
  }
}


