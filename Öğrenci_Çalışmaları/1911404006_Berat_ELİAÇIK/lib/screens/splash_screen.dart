import 'package:flutter/material.dart';
import 'package:projemmmm/common/theme_helper.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: ThemeHelper.primaryColor, //acilis ekrani rengi
          child: Center(
              child: Icon(Icons.traffic_outlined,
                  color: Colors.white, size: 100) //acilis ekrani icon
              )),
    );
  }
}
