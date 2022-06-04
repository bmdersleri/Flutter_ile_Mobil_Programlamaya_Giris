import 'package:flutter/material.dart';

class SelectButton extends StatelessWidget {
  String text;
  Function function;
  SelectButton({required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 170,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: ElevatedButton(
          onPressed: () {
            function();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(//yatay olarak yapılandırmak için kullanıyoruz.
              children: [
                Icon(Icons.zoom_in, color: Colors.black87, size: 45),
                Text(
                  text,
                  style: TextStyle(
                    color: Color(0xff2c2772),
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder( //yuvarlatışmış dikdörtgen ayarı için kullanmaktaayız.
              borderRadius: BorderRadius.circular(20),
              // <-- Radius
            ),
          ),
        ),
      ),
    );
  }
}
