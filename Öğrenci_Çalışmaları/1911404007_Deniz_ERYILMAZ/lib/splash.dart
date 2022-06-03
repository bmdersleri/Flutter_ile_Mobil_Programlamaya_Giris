import 'package:flutnix/loginscreen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
            child: ListView(shrinkWrap: true, children: const [
          Center(
              child: Text('SSHx',
                  style: TextStyle(
                      fontSize: 62,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          Center(
              child: Text('version Alpha 0.0.1',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white))),
          Center(
              child: Text('Loading....',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.white))),
        ])));
  }
}
