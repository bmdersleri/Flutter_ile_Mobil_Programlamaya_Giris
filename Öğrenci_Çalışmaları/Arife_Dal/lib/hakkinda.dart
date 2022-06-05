import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MobileApp());

class MobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hakkında",
      home: About(),
    );
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

Widget _buildTitle() {
  return Text(
    "Hakkında",
    style: TextStyle(fontSize: 30, color: Colors.white),
  );
}

Text _buildText(String title) {
  return Text(
    title,
    style: TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
  );
}

IconButton _buildButton(IconData icon) {
  return IconButton(
    onPressed: () {},
    icon: Icon(
      icon,
      color: Colors.white,
    ),
  );
}

class _AboutState extends State<About> {
  @override
  void initState() {
    fetchFileData();
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  String data = "";
  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString("txtFiles/About.txt");

    setState(() {
      data = responseText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.green,
          title: _buildTitle(),
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(children: [
            Text(
              data,
              style: TextStyle(fontSize: 20),
            )
          ]),
        ));
  }
}
