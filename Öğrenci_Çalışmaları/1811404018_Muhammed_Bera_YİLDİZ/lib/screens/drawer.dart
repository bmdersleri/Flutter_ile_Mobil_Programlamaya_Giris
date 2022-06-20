import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sut_cepte_mobile_app/screens/animals.dart';
import 'package:sut_cepte_mobile_app/screens/home.dart';
import 'package:sut_cepte_mobile_app/screens/login.dart';
import 'package:sut_cepte_mobile_app/screens/maliyet.dart';
import 'package:sut_cepte_mobile_app/screens/prices.dart';
import 'package:sut_cepte_mobile_app/screens/rasyon.dart';
import 'package:sut_cepte_mobile_app/screens/stock.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class DrawerMe extends StatelessWidget {
  const DrawerMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _auth.currentUser != null
                    ? _auth.currentUser!.email.toString()
                    : "",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Divider(
        thickness: 0.5,
        color: Colors.grey,
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));
        },
        leading: Icon(
          Icons.home,
          color: Colors.black,
        ),
        title: Text(
          "Ana Sayfa",
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Animals()));
        },
        iconColor: Colors.black,
        leading: Icon(
          Icons.cabin,
          color: Colors.black,
        ),
        title: Text(
          'Hayvanlar',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Stock()));
        },
        iconColor: Colors.orange[900],
        leading: Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.black,
        ),
        title: Text(
          'Stok',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MaliyetHesapla()));
        },
        iconColor: Colors.green,
        leading: Icon(
          Icons.calculate_outlined,
          color: Colors.black,
        ),
        title: Text(
          'Hesaplama',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Prices()));
        },
        iconColor: Colors.pink,
        leading: Icon(
          Icons.trending_up_rounded,
          color: Colors.black,
        ),
        title: Text(
          'Yem Fiyatları',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        height: 5.0,
      ),
      Divider(
        thickness: 0.5,
        color: Colors.grey,
      ),
      ListTile(
        onTap: () {
          _auth.signOut();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Login(),
          ));
        },
        iconColor: Colors.black,
        leading: Icon(Icons.logout),
        title: Text(
          'Çıkış',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }
}
