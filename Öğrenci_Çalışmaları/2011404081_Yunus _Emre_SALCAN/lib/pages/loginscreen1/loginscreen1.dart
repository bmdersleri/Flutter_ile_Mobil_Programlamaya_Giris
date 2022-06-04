import 'package:ApplicationName/pages/abapp/abapp.dart';
import 'package:flutter/material.dart';
import '../../ui/export.dart';



class Loginscreen1 extends StatefulWidget {
  const Loginscreen1({Key? key}) : super(key: key);


  @override
  _Loginscreen1State createState() => _Loginscreen1State();
}

class _Loginscreen1State extends State<Loginscreen1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: FvColors.screen2Background,
        body: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topLeft,
              child: const Padding(
                  padding: const EdgeInsets.only(left: 92, top: 188),
                  child: Text(
                    "Hosgeldin",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 50,
                      color: FvColors.textview2FontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, top: 19),
                child: SizedBox(
                  height: 312,
                  width: 314,
                  child: Image.asset("assets/image_ImageView_6-314x312.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 85, top: 62),
                child: SizedBox(
                  height: 55,
                  width: 245,
                  child: TextButton(
                    child: const Text("Giris",
                        style: TextStyle(
                          fontSize: 35,
                        )),
                    style: TextButton.styleFrom(
                      backgroundColor: FvColors.homebuttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 1,
                          color:FvColors.screen1Background,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Homescreen1()),);

                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 85, top: 62),
                child: SizedBox(
                  height: 55,
                  width: 245,
                  child: TextButton(
                    child: const Text("Uyguluma Hakkında",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    style: TextButton.styleFrom(
                      backgroundColor: FvColors.homebuttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 1,
                          color:FvColors.screen1Background,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Abappscreen1()),);

                    },
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 168, top: 149),
                child: SizedBox(
                  height: 46,
                  width: 79,
                  child: Image.asset("assets/image_ImageView_3-79x46.png"),
                ),
              ),
            ),
          ]),
        ));
  }
}
