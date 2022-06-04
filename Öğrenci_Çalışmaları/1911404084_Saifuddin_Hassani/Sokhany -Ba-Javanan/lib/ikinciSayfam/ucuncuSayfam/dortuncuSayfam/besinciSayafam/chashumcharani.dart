
import 'package:flutter/material.dart';

class chashum extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('چشم‌چرانی و نگاه آلوده'),
        backgroundColor: Colors.teal,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 2400,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 6),
                  child: Text('',

                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );


  }
}