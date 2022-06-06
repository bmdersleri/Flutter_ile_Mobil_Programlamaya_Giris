import 'package:deneme_flutter/utils/colors.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('About Us'),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 50),
            RowProperties(
              firstBox: "Name Surname :  ",
              secondBox: "Buğra Didin",
            ),
            SizedBox(height: 50),
            RowProperties(
              firstBox: "Email Address :  ",
              secondBox: "bugra80322@gmail.com",
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class RowProperties extends StatefulWidget {
  final String firstBox;
  final String secondBox;
  const RowProperties(
      {Key? key, required this.firstBox, required this.secondBox})
      : super(key: key);

  @override
  _RowPropertiesState createState() => _RowPropertiesState();
}

class _RowPropertiesState extends State<RowProperties> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text(
              widget.firstBox,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
          Container(
            child: Text(
              widget.secondBox,
              style: TextStyle(fontSize: 16),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
          ),
        ],
      ),
    );
  }
}
