import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MobileApp());

class MobileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kavram Örnekler",
      home: KavramText(),
    );
  }
}

class KavramText extends StatefulWidget {
  @override
  _KavramTextState createState() => _KavramTextState();
}

Widget _buildTitle() {
  return Text(
    "Kavram Öğretimi",
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

class _KavramTextState extends State<KavramText> {
  @override
  void initState() {
    fetchFileData();
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  String data = "";
  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString("txtFiles/TextFile.txt");

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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [Text(data)],
          )),
    );
  }
}
