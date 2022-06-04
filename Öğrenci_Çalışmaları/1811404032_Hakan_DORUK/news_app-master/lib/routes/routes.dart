import 'package:flutter/material.dart';
import 'package:news_app/pages/login.dart';
import 'package:news_app/pages/register.dart';
import 'package:news_app/widgets/home.dart';

class Routes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (context) => Login(),
        );
      case register:
        return MaterialPageRoute(
          builder: (context) => Register(),
        );
      case home:
        return MaterialPageRoute(
          builder: (context) => Home(),
        );
    }
  }
}

const String login = "/";
const String register = "register";
const String home = "home";
