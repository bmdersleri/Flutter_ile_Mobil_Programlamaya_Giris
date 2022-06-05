import 'package:flutter/material.dart';
import 'package:lisanstezistoktakipsistemi/screen/get_started.dart';
import 'package:firebase_core/firebase_core.dart';

 void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 runApp(MyApp());
 } 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) =>  GetStartedScreen(),
        });
  }
}

