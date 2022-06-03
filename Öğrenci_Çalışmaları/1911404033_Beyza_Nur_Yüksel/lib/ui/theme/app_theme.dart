import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    primaryColor: Color(0xFF5B37B6),
    accentColor: Color(0xFF5B37B6),
    indicatorColor: Color(0xFF291755),
    scaffoldBackgroundColor: Color.fromARGB(255, 100, 59, 134),
    backgroundColor: Color.fromARGB(255, 237, 224, 248),
    unselectedWidgetColor: Color.fromARGB(255, 84, 52, 117),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
    ),
    fontFamily: "Comfortaa",
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Color(0xFF382469),
        fontWeight: FontWeight.bold,
        fontSize: 60.0,
      ),
      headline4: TextStyle(
        color: Color(0xFF382469),
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 20.0,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      ),
      caption: TextStyle(
        color: Color.fromARGB(255, 163, 161, 161),
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Color(0xFF382469),
      selectionHandleColor: Color(0xFF382469),
      selectionColor: Color(0x1F382469),
    ),
  );
}
