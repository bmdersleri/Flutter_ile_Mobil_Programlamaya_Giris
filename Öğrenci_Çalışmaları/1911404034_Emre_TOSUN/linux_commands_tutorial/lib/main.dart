import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:app_1/aboutus.dart';
import 'package:app_1/advancedcommands.dart';
import 'package:app_1/basiccommands.dart';
import 'package:app_1/intermediatecommands.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linux Commands Tutorial',
      theme: null,  
      routes: {
        "basic": ((context) =>const BasicCommands()),
        "intermediate": ((context) =>const IntermediateCommands()),
        "advanced":(context) =>const AdvancedCommands(),
        "aboutus":(context)=>const Aboutus()

      },      
      home:const Home()
      );
  }

  
  }



class MainColors {

  static const Color backcolor1 =Color.fromARGB(199, 255, 102, 0);
  static const Color backcolor2 =Color.fromARGB(8, 18, 0, 183);
  static const Color txtColor = Colors.white;
  static const Color btnColor = Color.fromARGB(255, 241, 241, 255);
  static const Color btnTextColor = Color.fromARGB(255, 13, 0, 67);
  
}
class BtnProps {
  
  static const double  btnTextSize =20;
  static const double btnWidth = 80;
    static const double btnHeight = 45;


}
class FontProps {
  static const double mainTxtSize = 22;
  static const double mainLetterSpcing = 2;
  static const String appfont = "Rubik";
  
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [MainColors.backcolor1,MainColors.backcolor2 ])
           ),
          child: Scaffold(
            
            backgroundColor: Colors.transparent,
            
            body: Column(
              
                children:[

                  const SizedBox(height: 200,),
                  SizedBox(width: 170, height: 170,
                    child:AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                    FadeAnimatedText('Learn Linux terminal commands from basics to advanced.',textStyle:const TextStyle(letterSpacing:FontProps.mainLetterSpcing,color: MainColors.txtColor, fontFamily: " Rubik", fontSize: FontProps.mainTxtSize, fontWeight: FontWeight.bold)),
                    FadeAnimatedText('Start your linux tutorial today.',textStyle:const TextStyle(letterSpacing: FontProps.mainLetterSpcing,color: MainColors.txtColor, fontFamily: "Rubik", fontSize:FontProps.mainTxtSize,fontWeight: FontWeight.bold)),
                  ],   
                  ),),
                  
                  
                  const SizedBox(height: 200,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      mainButton(context, "Basic","basic"),
                      mainButton(context, "Intermediate","intermediate"),
                      mainButton(context,"Advanced","advanced")
                      
                    ]
                    
                  ),

                  Padding(
                    padding:const EdgeInsets.all(40),
                    child:  Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        mainButton(context, "About us", "aboutus")

                    ],
                          
                    )
                  )
                ]          
            )      
          )
        );
        
  }
}

ElevatedButton  mainButton(BuildContext context,buttonText,navigateTo) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),                                  
        minimumSize:const Size(BtnProps.btnWidth, BtnProps.btnHeight),
        primary:MainColors.btnColor ,
        ),
      onPressed:(){                           
        Navigator.pushNamed(context,navigateTo);},
        child: Text("$buttonText", style:Theme.of(context).textTheme.headline5?.copyWith(color:MainColors.btnTextColor,
          fontSize: BtnProps.btnTextSize, fontWeight: FontWeight.w500 ,fontFamily:"Verdana"),                                                
          )
    );
}