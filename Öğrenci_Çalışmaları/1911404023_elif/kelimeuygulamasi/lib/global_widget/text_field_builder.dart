import 'package:flutter/material.dart';

Container textFieldBuilder(
    {int height = 40,
    @required TextEditingController? textEditingController,
    Icon? icon,
    String? hintText,
    TextAlign textAlign = TextAlign.center}) {
  return Container(
    height: double.parse(height.toString()),
    padding: EdgeInsets.only(left: 16, right: 16),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(4)),
    margin: const EdgeInsets.only(left: 16, bottom: 4, top: 4),
    child: TextField(
      keyboardType: TextInputType.name,
      maxLines: 1,
      textAlign: textAlign,
      controller: textEditingController,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "RobotoRegular",
          decoration: TextDecoration.none,
          fontSize: 18),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          fillColor: Colors.transparent),
    ),
  );
}
