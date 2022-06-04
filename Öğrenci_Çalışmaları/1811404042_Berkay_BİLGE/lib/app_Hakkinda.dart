import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'endDraweMenu.dart';

class HakkindaPage extends StatelessWidget {
  const HakkindaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset('images/hamburger.png',
            fit: BoxFit.contain,
            width: 65,
            height: 35,
            alignment: Alignment.topLeft),
      ),
      endDrawer: DrawerMenu(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                'Uygulama Hakkinda',
                style: GoogleFonts.inter(
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Text(
                'Kullandığınız uygulama, bendeniz Berkay Bilge tarafından tasarlanmış ve kodlanmış olup huzurlarınıza sunulmuştur.',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 105, 105, 105))),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Text(
                'Umarım faydasını görürsünüz, sevgiler!',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 105, 105, 105))),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/Group 15 2.png'),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }
}
