import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);
  String textAd = 'Developer : Hasan Emre Alkan';
  String textMail = 'My mail adress : Hasan.alkan884@gmail.com';
  String textThanks =
      'Thanks for the use my app.Please contact me for your ideas and opinions.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'A B O U T',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            const Expanded(
              flex:2,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/gelir.png'),),
            ),
            SizedBox(height: 20,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 30,left:30),
                child: Text(
                  textAd,
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 30,left: 30),
                child: Text(
                  textMail,
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Text(
                  textThanks,
                  style: GoogleFonts.roboto(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
