import 'package:flutter/material.dart';
import 'pages/loginscreen1/loginscreen1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'GamerGuide',
        home: Loginscreen1());  }

}
