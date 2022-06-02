import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColor = Colors.green;
  static Color accentColor = Color(0xff20aebe);
  static Color shadowColor = Color(0xffa2a6af);

  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: 'Baloo',
      primarySwatch: Colors.green,
      colorScheme: ColorScheme.light(primary: Colors.green, secondary: Colors.teal),
      textTheme: TextTheme(
          headline3: TextStyle(
            color: Colors.green,
            fontFamily: 'Baloo',
          ),
          headline4: TextStyle(
            color: Colors.green,
            fontFamily: 'Baloo',
          )),
    );
  }

  static BoxDecoration fullScreenBgBoxDecoration(
      {String backgroundAssetImage = "assets/images/Common.bg.png"}) {
    return BoxDecoration(
      
      image: DecorationImage(image: AssetImage(backgroundAssetImage), fit: BoxFit.cover),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}