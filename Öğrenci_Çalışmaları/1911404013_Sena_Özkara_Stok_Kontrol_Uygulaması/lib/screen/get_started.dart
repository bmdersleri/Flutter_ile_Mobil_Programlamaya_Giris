import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lisanstezistoktakipsistemi/screen/dashboard.dart';
import 'package:lisanstezistoktakipsistemi/screen/login_screen.dart';


class GradientText extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const GradientText(
      this.text, {
        required this.gradient,
        this.style, required TextAlign locale,
        textAlign = TextAlign.center,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GetStartedScreenState createState() => _GetStartedScreenState();
}


class _GetStartedScreenState extends State<GetStartedScreen> {
  User? loggedInUser;
  // FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading=true;

  static const colorizeColors = [
    Color(0xFF072227),
    Color(0xFF35858B),
    Color(0xFF4FBDBA),
    Color(0xFFAEFEFF),
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Helvetica',


  );


  @override
  void initState() {
    FirebaseAuth.instance

        .authStateChanges()
        .listen((value) {
      if(value!=null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Dashboard()), (route) => false);
      } else {
        setState(() {
          _loading=false;
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[

                  const Padding(

                    //padding: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                   padding: EdgeInsets.fromLTRB(50,50,50,10),
                    //padding: EdgeInsets.all(50.20),
                    child:GradientText(
                          " STOK",
                      style: TextStyle(fontSize: 60,fontFamily: 'Helvetica'),
                      locale:TextAlign.center,
                      gradient: LinearGradient(colors: [
                        Color(0xFF43CEA2),
                        Color(0xFF185A9D),

                      ]),
                    ),

                   // Text('Stok Kontrol',style:TextStyle(fontFamily: 'Logo',fontSize: 55,fontWeight: FontWeight.bold,color:Colors.white)),
                  ),
                  const Padding(


                    padding: EdgeInsets.fromLTRB(50,10,50,10),
                    child:GradientText(

                          " KONTROL",
                      style: TextStyle(fontSize: 60,fontFamily: 'Helvetica'),
                      locale:TextAlign.center,
                      gradient: LinearGradient(colors: [
                        Color(0xFF43CEA2),
                        Color(0xFF185A9D),

                      ]),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50,10,50,50),
                    child:GradientText(
                          " SİSTEMİ",
                      style: TextStyle(fontSize: 60,fontFamily: 'Helvetica'),
                      locale:TextAlign.center,
                      gradient: LinearGradient(colors: [
                        Color(0xFF43CEA2),
                        Color(0xFF185A9D),

                      ]),
                    ),
                  ),

                  SizedBox(

                     width: MediaQuery.of(context).size.width*0.9,
                    child: DefaultTextStyle(style: const TextStyle(fontSize:30.0,fontWeight: FontWeight.bold,color:Colors.white),

                      child: Center(
                      child: AnimatedTextKit (
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        animatedTexts: [
                            ColorizeAnimatedText("Envanteri Yönet",
                            textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                                speed: const Duration( milliseconds:200)),
                            ColorizeAnimatedText("Gönderilerinizi "
                                "Yönetin",
                           textStyle: colorizeTextStyle,
                              colors: colorizeColors,
                                speed: const Duration( milliseconds:200)) ,
                            ColorizeAnimatedText("Analiz Et",
                          textStyle: colorizeTextStyle,
                           colors: colorizeColors,
                                speed: const Duration( milliseconds:200)) ,
                        ],
                      ),
                      )),
                  ),
                ],
              ),
            ),
            _loading?const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),):OutlinedButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>const LoginScreen()), (route) => false);

                OutlinedButton.styleFrom(
                  shadowColor: Colors.white,
                  side: const BorderSide(color:Colors.white),
                  shape:RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10.0)),
                  onSurface:  Color(0xFF35858B),
                );
              },



              child: const Padding(
                padding: EdgeInsets.symmetric(vertical:5.0,horizontal:18),
                child: Text('Başla',style: TextStyle(color: Color(0xFF35858B),fontSize: 25),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
