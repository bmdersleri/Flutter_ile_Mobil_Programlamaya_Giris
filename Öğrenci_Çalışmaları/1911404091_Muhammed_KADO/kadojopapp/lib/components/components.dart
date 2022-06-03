import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../Model/shar.dart';

@override
Widget defoutformfield({
  bool obscureText = false,
  required TextEditingController controller,
  TextInputType? keybord,
  required String lebel,
  required Function validator,
  Function? onChanged,
  Icon? icon,
  int? maxLength,
}) =>
    TextFormField(
        controller: controller,
        maxLength: maxLength,
        validator: (s) {
          validator(s);
        },
        keyboardType: keybord,
        textAlignVertical: TextAlignVertical.top,
        obscureText: obscureText,
        decoration: InputDecoration(
            filled: true,
            labelText: lebel,
            alignLabelWithHint: true,
            prefixIcon: icon,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))));

@override
Widget defoultButtun({
  required String text,
  required Function function,
  RoundedRectangleBorder? shape,
}) =>
    SizedBox(
      height: btnheight,
      width: btnWidth,
      child: MaterialButton(
        color: TextColors,
        onPressed: () {
          function();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Text(
          text.toUpperCase(),
          style:
              const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
        ),
      ),
    );

@override
Widget ProjectContainer({required String Tatole,required String Body,bool micc = false,}) =>
    Container(
      height: 200,
      width: 175,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 0.15)
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(80),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.only(right: 25, top: 8),
            child: Center(
                child: Icon(micc?
              Icons.mic:Icons.headset,
              size: 40,
              color: Colors.grey,
            )),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 5, right: 5),
            child: Text(Tatole,
              style: TextStyle(
                  color: TextColors, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 7, right: 5),
            child: Text(Body,
              style: TextStyle(color: TextColors, fontSize: 14),
            ),
          ),
        ],
      ),
    );

@override
Widget ProjectScreenContainer({
  required String Tatole,
  required String Body,
  required bool projectType,

}) =>
    Row(
      children: [
        Expanded(
          child: Container(
            height: 170,
            width: 175,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(80),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(80),
              ),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Icon(projectType?
              Icons.mic:Icons.headset,
                size: 40,
                color: Colors.grey,
              ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1, left: 1, right: 1),
                    child: Text(Tatole,style: TextStyle( color: TextColors, fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 3, right: 5),
                    child: Text(Body, style: TextStyle(color: TextColors, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        /*   Container(
      height: 170,
      width: 175,
      decoration: BoxDecoration(
        boxShadow:[
          BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 0.15
          )
        ] ,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(80),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const SizedBox(
            height: 50,
          ),

          Padding(
            padding:  const EdgeInsets.only(top: 2,left: 5 ,right: 1),
            child: Center(
              child: Text('${Tatole}',
                style:TextStyle(
                    color: TextColors,
                    fontWeight: FontWeight.bold,
                    fontSize: 17

                ),
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.only(top: 5,left: 7, right: 5),
            child: Text(Body,
              style: TextStyle(
                  color: TextColors,
                  fontSize: 10

              ),
            ),
          ),

        ],
      ),
    ),*/
      ],
    );
