import 'package:flutter/material.dart';
import 'main.dart';


class AboutusProps {
  static  String contact = "emret.1337@gmail.com" ;
  static  String owner = "Emre Tosun" ;
}

class Aboutus extends StatelessWidget {
  const Aboutus({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [MainColors.backcolor1,MainColors.backcolor2 ])   
      ),

      child: Column(
        children: [

           const SizedBox(height: 150,),
           Text("      This tutorial has been prepared for the beginners to help them understand the basics to advanced concepts covering Unix commands, from basic to advanced.",style: Theme.of(context).textTheme.headline6?.copyWith(color: MainColors.txtColor,fontSize: 18)),
           Text("Feel free to ask any questions if you need.",style: Theme.of(context).textTheme.headline6?.copyWith(color: MainColors.txtColor,fontSize: 18)),
           const SizedBox(height: 300,),
           Text("App Owner : " +AboutusProps.owner,style: Theme.of(context).textTheme.headline5?.copyWith(color: MainColors.txtColor)),
           const SizedBox(height: 40,),
           Text("Contact me : "+AboutusProps.contact,style: Theme.of(context).textTheme.headline6?.copyWith(color: MainColors.txtColor)),
        ],
      )
    );
  }
}