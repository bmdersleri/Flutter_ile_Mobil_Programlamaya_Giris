import 'package:flutter/material.dart';

class MastitValue extends StatelessWidget {
  String text;
  var control;
  MastitValue({Key? key, required this.text, required this.control})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
            ]),
        height: 70,
        width: 90,
        child: TextField(
          controller: control,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              hintText: text,
              hintStyle: const TextStyle(color: Colors.black38)),
        ),
      ),
    );
  }
}
