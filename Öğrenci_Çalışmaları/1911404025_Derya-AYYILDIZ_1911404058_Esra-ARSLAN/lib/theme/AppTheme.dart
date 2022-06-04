import 'package:flutter/material.dart';

class AppTheme {
  final darkblue = Color(0xff2c2772);
  final white = Color(0xfffafafa);
  final gray = Color(0xfff3f3f4);
  final black = Color(0xff212121);
  final blue = Color(0xff14279B);

  AppTheme._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Color(0xff2c2772),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.white,
      primaryVariant: Colors.white38,
      secondary: Colors.yellow,
    ),
    cardTheme: CardTheme(
      color: Colors.teal,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    // textTheme: TextTheme(
    //   title: TextStyle(
    //     color: Colors.white,
    //     fontSize: 20.0,
    //   ),
    //   subtitle: TextStyle(
    //     color: Colors.white70,
    //     fontSize: 18.0,
    //   ),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    // textTheme: TextTheme(
    //   title: TextStyle(
    //     color: Colors.white,
    //     fontSize: 20.0,
    //   ),
    //   subtitle: TextStyle(
    //     color: Colors.white70,
    //     fontSize: 18.0,
    //   ),
    // ),
  );
}