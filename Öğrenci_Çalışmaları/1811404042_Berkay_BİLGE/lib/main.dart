import 'package:flutter/material.dart';
import 'package:veggy/Corbalar.dart';

import 'homepage.dart';
import 'package:lottie/lottie.dart';
import 'package:change_app_package_name/change_app_package_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState(); //Sayfa ilk buildinde hangi kodlar calısacak?

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationController.forward();
    Future.delayed(Duration(seconds: 6)).then((value) => {
      //6sn sonra homepage'e gidecek.
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()))
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose(); //Splashi cope atar.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //sayfa iskeleti olusturma
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VEGGY',
              style: TextStyle(
                  color: Color.fromARGB(255, 76, 155, 80),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'images/hamburger.png', //Splashteki hamburger
                      ),
                      fit: BoxFit.contain)),
            ),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'images/yaprak.png',
                      ),
                      fit: BoxFit.contain)),
            ),
            Container(
              width: 200,
              height: 200,
              child: Lottie.asset('images/37302-square-loadingloader.json',
                  controller: _animationController, onLoaded: (composition) {
                _animationController.duration = composition.duration;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
