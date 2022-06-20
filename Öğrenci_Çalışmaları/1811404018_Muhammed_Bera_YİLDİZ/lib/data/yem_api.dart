import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YemApi {
  late FirebaseFirestore dbYem;

  YemApi() {
    dbYem = FirebaseFirestore.instance;
  }
  Widget getData() {
    return StreamBuilder<QuerySnapshot>(
      stream: dbYem.collection("Yemler").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Veri Bağlantısı Hatalı");
        }
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: getExpenseItems(snapshot),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => new ListTile(
              title: Card(
                color: Colors.white,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        doc['name'].toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      Text(
                        doc['kg'].toString() + " KG",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      Text(
                        doc['price'].toString() + " TL",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }
}
