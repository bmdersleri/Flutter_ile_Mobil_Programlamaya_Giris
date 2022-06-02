import 'package:css_colors/css_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: CSSColors.orange));
  }
}
