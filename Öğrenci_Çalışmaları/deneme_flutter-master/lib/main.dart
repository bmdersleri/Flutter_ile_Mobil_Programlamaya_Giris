import 'package:deneme_flutter/providers/user_provider.dart';
import 'package:deneme_flutter/screens/aboutus_screen.dart';
import 'package:deneme_flutter/screens/create_service_screen.dart';
import 'package:deneme_flutter/screens/homeowner_screen.dart';
import 'package:deneme_flutter/screens/homeuser_screen.dart';
import 'package:deneme_flutter/screens/login_screen.dart';
import 'package:deneme_flutter/screens/owner_service_screen.dart';
import 'package:deneme_flutter/screens/homeowner_screen.dart';
import 'package:deneme_flutter/screens/show_users_screen.dart';
import 'package:deneme_flutter/screens/signup_screen.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'responsive/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brothers Car Service',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(mobileScreenLayout: LoginScreen());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
