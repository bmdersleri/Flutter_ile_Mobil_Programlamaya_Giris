import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sut_cepte_mobile_app/providers/maliyet_listeleme.dart';
import 'package:sut_cepte_mobile_app/screens/counter.dart';
import 'package:sut_cepte_mobile_app/screens/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Firebase Bağlantıda Hata Oluştu")),
          );
        }
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => Counter(),
              ),
              ChangeNotifierProvider(
                create: (context) => MalitetListelePoriver(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Süt Cepte',
              home: StartPage(),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
