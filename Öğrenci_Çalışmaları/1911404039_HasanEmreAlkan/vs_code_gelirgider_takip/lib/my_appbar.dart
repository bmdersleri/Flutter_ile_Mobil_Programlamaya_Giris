import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_page.dart';
import 'about.dart';
import 'dart:math' as math;

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: InputPage.primaryColor,
      ),
      leading:  Transform.rotate(
        angle:180 * math.pi / 180,
        child: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout)),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
            icon: Icon(Icons.line_weight_sharp))
      ],
      centerTitle: true,
      title: Text(
        'Spending Limit',
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w400,
        ),
      ),
      elevation: 0,
    );
  }
}
