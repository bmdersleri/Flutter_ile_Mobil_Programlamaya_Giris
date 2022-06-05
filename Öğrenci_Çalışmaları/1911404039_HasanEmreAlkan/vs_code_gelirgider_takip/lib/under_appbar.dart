import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vs_code_gelirgider_takip/islem.dart';
import 'input_page.dart';

class UnderAppBar extends StatelessWidget {
  UnderAppBar({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {;
    double gelirToplam = 0;
    double giderToplam = 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: InputPage.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          )),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '₺',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Flexible(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('islemler')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      giderToplam=0;
                      gelirToplam = 0;
                      var snpsht = (snapshot.data! as QuerySnapshot).docs;
                      final int docsLength3 =
                          (snapshot.data! as QuerySnapshot).docs.length;

                      for (int i = 0; i < docsLength3; i++) {
                        if (user.uid == snpsht[i]['userId']) {
                          if (snpsht[i]['islemTuru'] == 'gelir') {
                            gelirToplam +=
                                double.parse(snpsht[i]['islemFiyati']);
                          }
                          if (snpsht[i]['islemTuru'] == 'gider') {
                            giderToplam +=
                                double.parse(snpsht[i]['islemFiyati']);
                          }
                        }
                      }
                      return Text((gelirToplam-giderToplam).toString(),
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600));
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.arrow_upward,
                          color: Colors.greenAccent, size: 30),
                      backgroundColor: Colors.white70,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Income',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Flexible(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('islemler')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              gelirToplam=0;
                              var snpsht =
                                  (snapshot.data! as QuerySnapshot).docs;
                              final int docsLength =
                                  (snapshot.data! as QuerySnapshot).docs.length;

                              for (int i = 0; i < docsLength; i++) {
                                if (user.uid == snpsht[i]['userId']) {
                                  if (snpsht[i]['islemTuru'] == 'gelir') {
                                    gelirToplam +=
                                        double.parse(snpsht[i]['islemFiyati']);
                                  }
                                }
                              }
                              return Text("₺" + gelirToplam.toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Expense',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Flexible(
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('islemler')
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              giderToplam=0;
                              var snpsht = (snapshot.data! as QuerySnapshot).docs;
                              final int docsLength2 =
                                  (snapshot.data! as QuerySnapshot).docs.length;

                              for (int i = 0; i < docsLength2; i++) {
                                if (user.uid == snpsht[i]['userId']) {
                                  if (snpsht[i]['islemTuru'] == 'gider') {
                                    giderToplam +=
                                        double.parse(snpsht[i]['islemFiyati']);
                                  }
                                }
                              }
                              return Text("₺" + giderToplam.toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.black54,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      child: Icon(Icons.arrow_downward,
                          color: Colors.redAccent, size: 30),
                      backgroundColor: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double getGelir(Islem islem) {
    if (user.uid == islem.userId && islem.islemTuru == 'gelir') {
      return (islem.islemFiyati);
    } else {
      return (islem.islemFiyati);
    }
  }

  double getGider(Islem islem) {
    if (user.uid == islem.userId && islem.islemTuru == 'gider') {
      return (islem.islemFiyati);
    } else {
      return (islem.islemFiyati);
    }
  }
}
