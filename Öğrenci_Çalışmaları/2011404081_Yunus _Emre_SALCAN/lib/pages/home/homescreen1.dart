import 'package:ApplicationName/pages/aboutheroscreen1/aboutheroscreen1.dart';
import 'package:flutter/material.dart';
import 'package:ApplicationName/ui/export.dart';
import 'package:ApplicationName/pages/aboutheroscreen2/aboutheroscreen2.dart';


class Homescreen1 extends StatefulWidget {
  const Homescreen1({Key? key}) : super(key: key);

  @override
  _Homescreen1State createState() => _Homescreen1State();
}

class _Homescreen1State extends State<Homescreen1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: FvColors.hscreen1Background,
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 316, top: 14),
                child: SizedBox(
                  height: 69,
                  width: 72,
                  child: Image.asset("assets/image_ImageView_4-72x69.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 300, top:0),
                  child: Text(
                    "User",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: FvColors.htextview8FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 23),
                  child: Container(
                      width: 257,
                      height: 94,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Padding(
                                padding: const EdgeInsets.only(bottom:15, left: 0),
                                child: Text(
                                  "Merhaba ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 48,
                                    color: FvColors.htextview3FontColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                        ],
                      ))),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 34, top: 23),
                child: SizedBox(
                  height: 54,
                  width: 341,
                  child: Image.asset("assets/Search_ImageView_12-341x54.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 39, top: 47),
                  child: Container(
                      width: 375,
                      height: 59,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Padding(
                                padding: const EdgeInsets.only(left: 0, top: 0),
                                child: Text(
                                  "Oyunlar",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: FvColors.htextview3FontColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: const Padding(
                                padding:
                                const EdgeInsets.only(left: 281, top: 17),
                                child: Text(
                                  "Hepsini Gör",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: FvColors.htextview8FontColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                          ),
                        ],
                      ))),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 23, top: 0),
                child: Container(
                  height: 267,
                  width: 373,
                  child: GestureDetector(
                    onTap: () {},
                    child:
                    Image.asset("assets/image_ImageButton_15-373x267.png"),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left : 23,top: 0),
                  child: Text(
                    "  Herolar",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 25,
                      color: FvColors.htextview3FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 118, top: 14),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image.asset("assets/image_ImageView_16-181x288.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: SizedBox(
                height: 34,
                width: 129,
                child: TextButton(
                  child: const Text("RAZE",
                      style: TextStyle(
                        fontSize: 15,
                        color: FvColors.htextview9Background,
                        fontWeight: FontWeight.normal,
                      )),
                  style: TextButton.styleFrom(
                    backgroundColor: FvColors.buttoncolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(
                        width: 20,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutheroscreen1()),);

                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 121, top: 28),
                child: SizedBox(
                  height: 319,
                  width: 173,
                  child: Image.asset("assets/image_ImageView_17-173x319.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: SizedBox(
                height: 34,
                width: 129,
                child: TextButton(
                  child: const Text("REYNA",
                      style: TextStyle(
                        fontSize: 15,
                        color: FvColors.htextview9Background,
                        fontWeight: FontWeight.normal,
                      )),
                  style: TextButton.styleFrom(
                    backgroundColor: FvColors.button2color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(
                        width: 20,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Aboutheroscreen2()),);

                  },
                ),
              ),
            ),
          ]),
        ));
  }
}
